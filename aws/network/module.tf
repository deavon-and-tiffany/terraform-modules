module "network" {
  source = "../../org/network"
}

# united states
module "eu-west-2" {
  source = "../region"
  region = "eu-west-2"
}
# module "us-east-2" {
#   source = "../region"
#   region = "us-east-2"
# }
# module "us-west-1" {
#   source = "../region"
#   region = "us-west-1"
# }
# module "us-west-2" {
#   source = "../region"
#   region = "us-west-2"
# }

# # asia pacific
# module "ap-east-1" {
#   source = "../region"
#   region = "ap-east-1"
# }
# module "ap-northeast-1" {
#   source = "../region"
#   region = "ap-northeast-1"
# }
# module "ap-northeast-2" {
#   source = "../region"
#   region = "ap-northeast-2"
# }
# module "ap-northeast-3" {
#   source = "../region"
#   region = "ap-northeast-3"
# }
# module "ap-south-1" {
#   source = "../region"
#   region = "ap-south-1"
# }
# module "ap-southeast-1" {
#   source = "../region"
#   region = "ap-southeast-1"
# }
# module "ap-southeast-2" {
#   source = "../region"
#   region = "ap-southeast-2"
# }

# # canada
# module "ca-central-1" {
#   source = "../region"
#   region = "ca-central-1"
# }

# europe
# module "eu-north-1" {
#   source = "../region"
#   region = "eu-north-1"
# }
# module "eu-west-1" {
#   source = "../region"
#   region = "eu-north-1"
# }
module "eu-west-2" {
  source = "../region"
  region = "eu-west-2"
}
# module "eu-west-3" {
#   source = "../region"
#   region = "eu-west-3"
# }
# module "eu-central-1" {
#   source = "../region"
#   region = "eu-central-1"
# }

# # south america
# module "sa-east-1" {
#   source = "../region"
#   region = "sa-east-1"
# }

# # middle east
# module "me-south-1" {
#   source = "../region"
#   region = "me-south-1"
# }

# # china
# module "cn-north-1" {
#   source = "../region"
#   region = "cn-north-1"
# }
# module "cn-northwest-1" {
#   source = "../region"
#   region = "cn-northwest-1"
# }

# # us government
# module "us-gov-east-1" {
#   source = "../region"
#   region = "us-gov-east-1"
# }
# module "us-gov-west-1" {
#   source = "../region"
#   region = "us-gov-west-1"
# }
