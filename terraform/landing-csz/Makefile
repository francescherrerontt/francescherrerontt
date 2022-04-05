# Mandatory: Id of the subscription for the resources deployed from this directory
SUBSCRIPTION_ID :=

-include ../Makefile.landing.mk

bootstrap: az-login
	@echo '-----------------'
	@echo 'Initialize Terraform Global State'
	@echo '-----------------'
	@pwd
	@terraform -chdir=local-rg-tfstates init
	@terraform -chdir=local-rg-tfstates validate
	@export ARM_SUBSCRIPTION_ID="$(SUBSCRIPTION_ID)" && terraform -chdir=local-rg-tfstates apply
	@terraform -chdir=local-rg-tfstates output > $(BACKEND_CFG)

destroy-bootstrap: az-login
	@echo '-----------------'
	@echo 'Destroy Terraform Global State'
	@echo '-----------------'
	@pwd
	@export ARM_SUBSCRIPTION_ID="$(SUBSCRIPTION_ID)" && terraform -chdir=local-rg-tfstates destroy
