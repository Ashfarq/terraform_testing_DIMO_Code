module "network" {
  source = "./modules/network"


  vpc-cidr = "10.30.1.0/24"
  vpc-name = "dimo-qa-vpc"

  pub-1 = "10.30.1.0/28"
  pub-2 = "10.30.1.16/28"

  pvt-1 = "10.30.1.32/27"
  pvt-2 = "10.30.1.64/27"

  db-1 = "10.30.1.96/27"
  db-2 = "10.30.1.128/27"

  pub_1-name = "dimo-qa-pub_sub-apse_1a"
  pub_2-name = "dimo-qa-pub_sub-apse_1b"

  pvt_1-name = "dimo-qa-pvt_sub-apse_1a"
  pvt_2-name = "dimo-qa-pvt_sub-apse_1b"

  db_1-name = "dimo-qa-db_sub-apse_1a"
  db_2-name = "dimo-qa-db_sub-apse_1b"

  pub-az1 = "ap-southeast-1a"
  pub-az2 = "ap-southeast-1b"

  pvt-az1 = "ap-southeast-1a"
  pvt-az2 = "ap-southeast-1b"

  db-az1 = "ap-southeast-1a"
  db-az2 = "ap-southeast-1b"

  igw-name = "dimo-qa-igw"
}
