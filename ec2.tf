module "compute" {
  source = "./modules/compute"


  ami           = "ami-0933f1385008d33c4"
  instance-type = "c6a.2xlarge"
  instance-name = "dimo-qa-pvt-ec2"
  pvt-sub1      = module.network.pvt-1
  vpc-sg        = module.security.pvt-id


}
