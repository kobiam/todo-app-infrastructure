terraform {
  backend "azurerm" {
    resource_group_name  = "todo-app"
    storage_account_name = "tfstateaccounttodoapp"
    container_name       = "tfstate"
    key                  = "fastapi-app.tfstate"
  }
}

output "app_url" {
  value = "https://${azurerm_linux_web_app.main.default_hostname}"
}
