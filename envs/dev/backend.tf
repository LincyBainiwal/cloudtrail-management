# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }

terraform {
  cloud {
    organization = "lincy21_terraform"

    # workspaces {
    #   name = "cloudtrail-vcs-dev"
    # }
    workspaces {
      name = "cloudtrail-vcs-dev"
    }
  }
}
