# Create frontend web server

resource "aws_instance" "jumpbox-server" {
  ami                         = var.ami2
  instance_type               = var.instance_type2
  vpc_security_group_ids      = [aws_security_group.jumpbox-server-sg.id]
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.public-subnet1.id
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 30
    delete_on_termination = true
  }

  tags = merge(
    {
      Name        = "${var.project}-jumpbox-srv",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}


# Create security group for jumpbox
resource "aws_security_group" "jumpbox-server-sg" {
  name        = "jumpbox-server-sg"
  description = "Allow internal traffics"
  vpc_id      = aws_vpc.main-vpc.id

  ingress = [
    {
      description      = "icmp"
      from_port        = -1
      to_port          = -1
      protocol         = "icmp"
      cidr_blocks      = ["10.0.0.0/16"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    },

    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["71.150.189.42/32"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    }
  ]


  egress = [
    {
      description      = "for all outgoing traffics"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = merge(
    {
      Name        = "${var.project}-jumpbox-srv-sg",
      Project     = var.project,
      Environment = var.environment
    },
    var.tags
  )
}
