#vpc tfvars
region                = "us-east-1"
vpcname               = "netflix-vpc"
vpc_cidr              = "10.0.0.0/16"
publicsubnet1_cidr    = "10.0.0.0/24"
publicsubnet2_cidr    = "10.0.10.0/24"
privatesubnet1_cidr   = "10.0.1.0/24"
privatesubnet2_cidr   = "10.0.2.0/24"
availability_zones-1a = "us-east-1a"
availability_zones-1b = "us-east-1b"

# tag tfvars
project     = "mobikart"
environment = "dev"

# ec2 tfvars
ami           = "ami-05b8e48c2cd25d2cf"
ami2          = "ami-08d4ac5b634553e16"
instance_type = "t3.small"
instance_type2 = "t2.micro"
key_name      = "virtual-kp"
