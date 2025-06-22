terraform {
  backend "azurerm" {
    resource_group_name  = "todo-app"
    storage_account_name = "tfstateaccounttodoapp"
    container_name       = "tfstate"
    key                  = "fastapi-app.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  resource_provider_registrations  = "none"
}

output "app_url" {
  value = "https://${azurerm_linux_web_app.main.default_hostname}"
}
