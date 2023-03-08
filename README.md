# Terraform-Proficiency-Silver-thandler

# Introduction 
This repo contains Terraform configurations to deploy an Azure App Service and all of its dependencies.

# Getting Started

1.	Download and install
    - Az CLI - [Download Link](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
    - Teraform - [Download Link](https://www.terraform.io/downloads)


# Run Deployments Locally
Note: the following assumes the code was cloned to the c:\repos\APIM directory.
1. Login to az login with the following command
```
az login
```

2. Navigate to the src folder
3. Run the Terraform init command for the targeted environment
``` 
terraform init -backend-config="..\backend_tfvars\dev_backend.tfvars" 
```

4. After Terraform's backend has been initiated to the environment's remote state you can run the plan command `terraform plan` command to see what Azure resources will be create/updated/destroyed.

```
terraform plan -var-file "../tfvars/dev.tfvars"
```
5. Once the plan command runs succussfully and the expected changes are reflexed, the changes can be applied locally. However it is recommened that changes are applied via the established GitHub Workflows. 
```
terraform apply -var-file "../tfvars/dev.tfvars"
```

# Workflows
       
- [**Terraform Plan/Apply**](.github/workflows/terraform-plan-apply.yml)
    - **Trigger** - Completed PR on the main branch.
    - **Jobs**
        - A job for each defined environment (Current environments: dev, qa, production)
        - A execution of a job requires an approval for the given environment
        - **Steps**
            - Call the Terraform Apply Action