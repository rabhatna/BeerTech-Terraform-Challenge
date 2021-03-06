# Configure the Microsoft Azure Provider
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

# module "instance" {
#   source = "./modules/Instance"
# }
#
# module "postgressqlDB" {
#   source = "./modules/PostgresDB"
# }

module "azureK8s" {
  source = "./modules/AzureK8s"
}
