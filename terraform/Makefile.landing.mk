SHELL := /bin/bash

## Set the SUBSCRIPTION_ID variable in each of the landing directories' Makefile, *not here*.
ifndef SUBSCRIPTION_ID
$(error Need to set SUBSCRIPTION_ID variable in the landing Makefile)
endif

export TF_PLUGIN_CACHE_DIR := $(HOME)/.terraform.d/plugin-cache

BACKEND_CFG  = $(CURDIR)/../backend.tfvars

DIRS := $(wildcard rg-*)

all:
	@echo Default target disabled
	@echo "Subscription: $(SUBSCRIPTION_ID)"

az-login:
	echo az account set --subscription $(SUBSCRIPTION_ID)


COMMON_ARGS = -var-file=$(BACKEND_CFG) -var-file=$(CURDIR)/landing.tfvars

define GENTARGETS

$(eval TFARGS = $(COMMON_ARGS) -var-file=$(abspath $(DIR))/group.tfvars)
$(eval SUBDIRS = $(shell find $(DIR) -maxdepth 1 -mindepth 1 -type d -not -name '.*' -not -path "*.disabled" | sort ))
$(eval SUBDIRS_R = $(shell find $(DIR) -maxdepth 1 -mindepth 1 -type d -not -name '.*' -not -path "*.disabled" | sort -r))

# This is needed since we are mixing having subdirectories with TF files (normally),
# and having all the files in the rg-directory (rg-tfstates)
$(eval ifeq ($(SUBDIRS),)
SUBDIRS := $(DIR)
SUBDIRS_R := $(DIR)
endif)

init-$(DIR):
	for dir in $(SUBDIRS); do \
		echo "INIT $$$${dir}"; terraform -chdir=$$$${dir} init -reconfigure -backend-config=$(BACKEND_CFG); \
	done

validate-$(DIR):
	for dir in $(SUBDIRS); do \
		echo "VALIDATE $$$${dir}"; terraform -chdir=$$$${dir} validate; \
	done

plan-$(DIR):
	for dir in $(SUBDIRS); do \
		echo "PLAN $$$${dir}"; export ARM_SUBSCRIPTION_ID="$(SUBSCRIPTION_ID)" && terraform -chdir=$$$${dir} plan $(TFARGS); \
	done

apply-$(DIR):
	for dir in $(SUBDIRS); do \
		echo "APPLY $$$${dir}"; export ARM_SUBSCRIPTION_ID="$(SUBSCRIPTION_ID)" && terraform -chdir=$$$${dir} apply $(TFARGS) || exit 1; \
	done

destroy-$(DIR):
	for dir in $(SUBDIRS_R); do \
		echo "DESTROY $$$${dir}"; export ARM_SUBSCRIPTION_ID="$(SUBSCRIPTION_ID)" && terraform -chdir=$$$${dir} destroy $(TFARGS) || exit 1; \
	done

output-$(DIR):
	for dir in $(SUBDIRS); do \
		echo "OUTPUT $$$${dir}"; export ARM_SUBSCRIPTION_ID="$(SUBSCRIPTION_ID)" && terraform -chdir=$$$${dir} output || exit 1; \
	done
endef

#$(info $(foreach DIR, $(DIRS), $(call GENTARGETS)))
$(foreach DIR, $(DIRS), $(eval $(call GENTARGETS)))
