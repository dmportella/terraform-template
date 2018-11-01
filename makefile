TERRAFORM_ENVIRONMENT?=local

#for logging add TF_LOG=TRACE to the start of a terraform call

default:
	@echo "Terraform Make"
	@echo "Please run 'make init' first"
	@echo "Commands available: init, plan, apply and destroy"
	@echo "For init-backend please set the PROJECT_NAME env variable"
	@echo
	@echo "Environment variables"
	@echo "TERRAFORM_ENVIRONMENT="${TERRAFORM_ENVIRONMENT}
	@echo "TERRAFORM_BACKEND="${TERRAFORM_BACKEND}

perms:
	@chmod 0755 terraform.d/plugins/linux_amd64/custom-provider

init:
	@terraform init -input=false

init-backend:
	@terraform init -input=false -backend-config="key=${PROJECT_NAME}-${TERRAFORM_ENVIRONMENT}" -backend-config="access_key=${AWS_ACCESS_KEY_ID}" -backend-config="secret_key=${AWS_SECRET_ACCESS_KEY}"

plan: perms
	@terraform plan -input=false -out=terraform.plan -var-file=environments/${TERRAFORM_ENVIRONMENT}/terraform.tfvars

apply: perms
	@terraform apply -input=false terraform.plan

destroy: perms
	@terraform destroy -input=false -var-file=environments/${TERRAFORM_ENVIRONMENT}/terraform.tfvars