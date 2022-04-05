SHELL := /bin/bash
.EXPORT_ALL_VARIABLES:

export TF_PLUGIN_CACHE_DIR := $(HOME)/.terraform.d/plugin-cache

DIRS = $(filter-out $(wildcard landing-*/rg-*.disabled),$(wildcard landing-*/rg-*))

all:
	@echo "Default target disabled"

bootstrap: $(TF_PLUGIN_CACHE_DIR)
	$(MAKE) -C landing-csz bootstrap

destroy-bootstrap:
	$(MAKE) -C landing-csz destroy-bootstrap

tf-fmt-check: $(TF_PLUGIN_CACHE_DIR)
	terraform fmt -recursive -check

tf-fmt: $(TF_PLUGIN_CACHE_DIR)
	terraform fmt -recursive

$(TF_PLUGIN_CACHE_DIR):
	mkdir -p $@

define GENTARGETS

$(eval TARGET = $(subst /,-,$(subst landing-,,$(DIR))))
$(eval PARTS = $(subst /, ,$(DIR)))
tf-init-$(TARGET): $(TF_PLUGIN_CACHE_DIR)
	$$(MAKE) -C $(firstword $(PARTS)) init-$(lastword $(PARTS))

tf-validate-$(TARGET):
	$$(MAKE) -C $(firstword $(PARTS)) validate-$(lastword $(PARTS))

tf-plan-$(TARGET):
	$$(MAKE) -C $(firstword $(PARTS)) plan-$(lastword $(PARTS))

tf-apply-$(TARGET):
	$$(MAKE) -C $(firstword $(PARTS)) apply-$(lastword $(PARTS))

tf-destroy-$(TARGET):
	$$(MAKE) -C $(firstword $(PARTS)) destroy-$(lastword $(PARTS))

tf-output-$(TARGET):
	$$(MAKE) -C $(firstword $(PARTS)) output-$(lastword $(PARTS))
endef

#$(info $(foreach DIR, $(DIRS), $(call GENTARGETS)))
$(foreach DIR, $(DIRS), $(eval $(call GENTARGETS)))

cwz-%:
	script/new-cwz $(subst _, ,$(shell echo $@ | sed -e 's/^cwz-//'))
