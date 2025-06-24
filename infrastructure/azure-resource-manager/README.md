# Prep

get the private-dns zone id

```bash
az network private-dns zone show \
  --name private.postgres.database.azure.com \
  --resource-group todo-app \
  --query id -o tsv
```
