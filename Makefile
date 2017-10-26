# Makefiles expect tabs, not spaces!

ANSIBLE = ansible-playbook
ANSIBLE_VAULT = ansible-vault

ANSIBLE_VAULT_VARS = --vault-password-file=~/.ansible/vault-password -i playbooks/hosts

deploy:
	$(ANSIBLE) $(ANSIBLE_VAULT_VARS) playbooks/hearth.yml
