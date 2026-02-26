# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }

terraform {
  cloud {
    organization = "lincy21_terraform"

    workspaces {
      name = "cloudtrail-cli-dev"
    }
  }
}
