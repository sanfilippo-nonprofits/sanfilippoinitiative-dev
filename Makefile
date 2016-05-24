.DEFAULT_GOAL := help
.PHONY: help

ENV = dev
RUN_TIMESTAMP = $(shell date +%Y.%m.%d.%H%M)
PLAYBOOK ?=

## Get dependencies
# Example: make deps
deps:
	ansible-galaxy install -p ansible/vendor -r ansible/roles.yml

## Clean up
clean:
	rm -rf ansible/vendor/*

## Runs any playbook
# Examples: make playbook PLAYBOOK=support/backup.yml
playbook:
	echo $(RUN_TIMESTAMP)
	ansible-playbook -i ansible/inventory/mydevil \
		--extra-vars hosts=s2 \
		--extra-vars env=$(ENV) \
		--extra-vars run_timestamp=$(RUN_TIMESTAMP) \
		--extra-vars @ansible/vars/environment/$(ENV)/services.yml \
		ansible/playbooks/$(PLAYBOOK)
## Prints this help
help:
	@grep -h -E '^#' -A 1 $(MAKEFILE_LIST) | grep -v "-" | \
	awk 'BEGIN{ doc_mode=0; doc=""; doc_h=""; FS="#" } { \
		if (""!=$$3) { doc_mode=2 } \
		if (match($$1, /^[%.a-zA-Z_-]+:/) && doc_mode==1) { sub(/:.*/, "", $$1); printf "\033[34m%-30s\033[0m\033[1m%s\033[0m %s\n\n", $$1, doc_h, doc; doc_mode=0; doc="" } \
		if (doc_mode==1) { $$1=""; doc=doc "\n" $$0 } \
		if (doc_mode==2) { doc_mode=1; doc_h=$$3 } }'

# creates empty `.make` if it does not exist
# run `make deps` if you want to auto generate `.make` file
.make:
	echo "" > .make
