# Code to create vpc with cidr range
resource "aws_vpc" "main-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = merge(
    {
      Name        = "${var.project}-vpc",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}

# code to create public subnet
resource "aws_subnet" "public-subnet1" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = var.publicsubnet1_cidr
  availability_zone       = var.availability_zones-1a
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name        = "${var.project}-Public-SN1",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}

# code to create public subnet2
resource "aws_subnet" "public-subnet2" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = var.publicsubnet2_cidr
  availability_zone       = var.availability_zones-1b
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name        = "${var.project}-Public-SN2",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}

# code to create private subnet
resource "aws_subnet" "private-subnet1" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = var.privatesubnet1_cidr
  availability_zone       = var.availability_zones-1a
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name        = "${var.project}-Private-SN1",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}

# code to create private subnet
resource "aws_subnet" "private-subnet2" {
  vpc_id                  = aws_vpc.main-vpc.id
  cidr_block              = var.privatesubnet2_cidr
  availability_zone       = var.availability_zones-1a
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name        = "${var.project}-Private-SN2",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}


# code to create internet gateway
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = merge(
    {
      Name        = "${var.project}-igw",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}

# code to provision elastic ip for nat gateway
# Allocate Elastic IP Address for Nat-Gateway
resource "aws_eip" "elastic-ip" {
  vpc = true

  tags = merge(
    {
      Name        = "${var.project}-eip",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )

}

# Create Nat Gateway
resource "aws_nat_gateway" "main-nat" {
  allocation_id = aws_eip.elastic-ip.id
  subnet_id     = aws_subnet.public-subnet1.id

  tags = merge(
    {
      Name        = "${var.project}-nat",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )

}

# Create Public Route Table and Configure Route
resource "aws_route_table" "public-routetable" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }

  tags = merge(
    {
      Name        = "${var.project}-public-rt",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )

}

# Associate Public Route Table with Public subnet 
resource "aws_route_table_association" "public-subnet1-association" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.public-routetable.id
}

# Associate Public Route Table with Public subnet 
resource "aws_route_table_association" "public-subnet2-association" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.public-routetable.id
}


# Create Private Route Table and configure route
resource "aws_route_table" "private-routetable" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main-nat.id
  }

  tags = merge(
    {
      Name        = "${var.project}-private-rt",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )

}

# Associate Private Route Table with Private Subnet
resource "aws_route_table_association" "private-subnet1-association" {
  subnet_id      = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.private-routetable.id
}
resource "aws_route_table_association" "private-subnet2-association" {
  subnet_id      = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.private-routetable.id
}