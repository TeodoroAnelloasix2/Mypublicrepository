aws_region = "us-east-1"
owner = "demo-wordpress-04"
aws_region_az = "a"
vpc_cidr_block = "10.0.0.0/16"
vpc_dns_support = true
vpc_dns_hostnames = true
sg_ingress_proto = "tcp"
sg_ingress_ssh = "22"
sg_egress_proto = "-1"
sg_egress_all = "0"
sg_egress_cidr_block = "0.0.0.0/0"
sg_ingress_cidr_block = "0.0.0.0/0"
sbn_public_ip = true
sbn_cidr_block = "10.0.1.0/24"
rt_cidr_block = "0.0.0.0/0"
# amazon ami
##instance_ami = "ami-04ad2567c9e3d7893"
# ubuntu
instance_ami = "ami-08c40ec9ead489470"
instance_type = "t2.micro"
#key_pair = "joc-key-pair"
key_pair_name = "demo-wordpress-pind04"
root_device_type = "gp2"
root_device_size = "50"

