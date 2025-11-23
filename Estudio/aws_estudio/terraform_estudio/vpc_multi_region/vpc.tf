resource "aws_vpc" "vpc_virginia" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name="vpc-virgina"
    Manteiner="italianodev"
    Enviroment="development"
  }
  provider = aws.nvirginia
}

resource "aws_vpc" "vpc_ohio" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name="vpc-ohio"
    Manteiner="italianodev"
    Enviroment="Integration"
  }
  provider = aws.ohio
}
