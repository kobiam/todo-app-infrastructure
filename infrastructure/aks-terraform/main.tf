terraform {
  backend "azurerm" {
    resource_group_name  = "todo-app"
    storage_account_name = "tfstateaccounttodoapp"
    container_name       = "tfstate"
    key                  = "fastapi-app.tfstate"
  }
}

output "app_url" {
  value = "https://${azurerm_app_service.main.default_site_hostname}"
}
