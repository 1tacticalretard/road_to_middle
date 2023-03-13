# Terraform -- webapp_with_hashicorp_vault

A simple todo-app with Hashicorp Vault integration

## How to Run

1. Make sure [HC Vault](https://developer.hashicorp.com/vault/docs/install) is installed and run on your local host.
2. (optional) For analysis purposes, check the actions provided in [the original app repository](https://github.com/harshsinghvi/todo-app). Those are duplicated inside the manifest.
3. Get your database and the connection URI at [mongodb.net](https://www.mongodb.com/) and set the MONGO_DB_URI environment variable in the following fashion:
    * Once HC Vault is enabled, run this command having the copied MongoDB URI pasted instead of the template one:

    ```
    vault kv put secret/todo-app link=""mongodb+srv://<USER>:<PASS>@cluster0.******.mongodb.net/todo-app""
    ```
    Verify the changes by running:
    ```
    vault kv get secret/todo-app
    ```
4. Run:
```
terraform init

terraform apply
```

 **In approximately 5-7 minutes** the app will be run and get accessible through the link of <your_instance_public_ip>:3000 .