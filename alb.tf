module "alb" {
  source = "./modules/alb"

  alb-name = "dimo-qa-pub-alb"
  pub-1    = module.network.pub-1
  pub-2    = module.network.pub-2

  alb-sg = module.security.alb-sg

  vpc-id = module.network.vpc-id

}
