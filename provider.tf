# # Specify the provider and access details
# provider "aws" {
#   version    = "~> 2.30"
#   access_key = var.access_key
#   secret_key = var.secret_key
#   region     = var.aws_region
# }

provider "aws" {
#  version    = "~> 2.30"
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

provider "aws" {
  alias  = "lambda"
  version    = "~> 3.19"
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}