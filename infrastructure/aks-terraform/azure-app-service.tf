provider "azurerm" {
  features {}
}

variable "location" {
  default = "eastus"
}

resource "azurerm_resource_group" "main" {
  name     = "rg-fastapi-demo"
  location = var.location
}

resource "azurerm_app_service_plan" "main" {
  name                = "fastapi-service-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "Linux"
  reserved            = true  # required for Linux

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "fastapi-webapp-demo"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_app_service_plan.main.id

  site_config {
    linux_fx_version = "DOCKER|todoappreg.azurecr.io/fastapi-backend:latest"

    acr_use_managed_identity_credentials = true
    acr_username                         = null  # required to be null if using managed identity
    acr_password                         = null
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    WEBSITES_PORT = "8000"  # FastAPI default port
  }
}

# Grant App Service access to pull from ACR
resource "azurerm_role_assignment" "acr_pull" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_app_service.main.identity.principal_id
}

data "azurerm_container_registry" "acr" {
  name                = "todoappreg"
  resource_group_name = "todo-app"
}
