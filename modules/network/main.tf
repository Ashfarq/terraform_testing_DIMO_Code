############ Main VPC ####################

resource "aws_vpc" "main-vpc" {
  cidr_block = var.vpc-cidr


  tags = {
    Name = var.vpc-name

  }
}

############ Public Subnet ####################


resource "aws_subnet" "pub-1" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.pub-1
  availability_zone = var.pub-az1

  tags = {
    Name = var.pub_1-name
  }
}

resource "aws_subnet" "pub-2" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.pub-2
  availability_zone = var.pub-az2

  tags = {
    Name = var.pub_2-name
  }
}

############ Private Subnet ####################

resource "aws_subnet" "pvt-1" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.pvt-1
  availability_zone = var.pvt-az1

  tags = {
    Name = var.pvt_1-name
  }
}

resource "aws_subnet" "pvt-2" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.pvt-2
  availability_zone = var.pvt-az2

  tags = {
    Name = var.pvt_2-name
  }
}


############ DB Subnet ####################

resource "aws_subnet" "db-1" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.db-1
  availability_zone = var.db-az1

  tags = {
    Name = var.db_1-name
  }
}

resource "aws_subnet" "db-2" {
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = var.db-2
  availability_zone = var.db-az2

  tags = {
    Name = var.db_2-name
  }
}



############# Internet Gateway ######################

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = var.igw-name
  }
}


################ NAT gateway #####################

resource "aws_eip" "ip" {
  #domain = true
  tags = {
    Name = "dimo-qa-nat-eip"
  }
}
resource "aws_nat_gateway" "nat-gt" {
  allocation_id = aws_eip.ip.id
  subnet_id     = aws_subnet.pub-1.id

  tags = {
    Name = "dimo-qa-nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}


########### Public Route Tables #######################

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "dimo-qa-pub-rt"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pub-1.id
  route_table_id = aws_route_table.pub-rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pub-2.id
  route_table_id = aws_route_table.pub-rt.id
}



########### Private Route Tables #######################

resource "aws_route_table" "pvt-rt" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gt.id
  }



  tags = {
    Name = "dimo-qa-pvt-rt"
  }
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.pvt-1.id
  route_table_id = aws_route_table.pvt-rt.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.pvt-2.id
  route_table_id = aws_route_table.pvt-rt.id
}




########### DB Route Tables #######################

resource "aws_route_table" "db-rt" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gt.id
  }



  tags = {
    Name = "dimo-qa-db-rt"
  }
}

resource "aws_route_table_association" "e" {
  subnet_id      = aws_subnet.db-1.id
  route_table_id = aws_route_table.db-rt.id

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "aws_route_table_association" "f" {
  subnet_id      = aws_subnet.db-2.id
  route_table_id = aws_route_table.db-rt.id

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}




