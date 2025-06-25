# Prep / Debug

get the private-dns zone id

```bash
az network private-dns zone show \
  --name private.postgres.database.azure.com \
  --resource-group todo-app \
  --query id -o tsv
```

enable admin user of ACR

```bash
az acr credential show --name todoappreg --query "username" --output tsv
az acr update --name todoappreg --admin-enabled true
```

get the username and password of the container registry

```bash
az acr credential show --name todoappreg --query "username" --output tsv
az acr credential show --name todoappreg --query "passwords[0].value" --output tsv
```

check the current VNet associations

```bash
az containerapp show \
  --name fastapi-backend \
  --resource-group todo-app \
  --query "properties.environmentId"

az containerapp env show --ids <output_from_above>
```
