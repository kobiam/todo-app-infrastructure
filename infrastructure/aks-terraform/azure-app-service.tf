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

resource "azurerm_service_plan" "main" {
  name                = "fastapi-service-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "main" {
  name                = "fastapi-webapp-demo"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = azurerm_service_plan.main.id

  site_config {
    application_stack {
      docker_image_name        = "backend:latest"
      docker_registry_url      = "https://todoappreg.azurecr.io"
    }

    always_on = true
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    WEBSITES_PORT = "8000"  # FastAPI default port
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
  }
}

# Grant App Service access to pull from ACR
resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_linux_web_app.main.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.main.id
}

data "azurerm_container_registry" "acr" {
  name                = "todoappreg"
  resource_group_name = "todo-app"
}
