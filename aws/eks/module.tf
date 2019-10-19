module "cluster" {
  source      = "./cluster"
  assume_role = var.assume_role

  name   = var.name
  vpc_id = var.vpc_id

  org    = var.org
  owners = var.owners
}
