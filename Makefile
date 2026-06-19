# Bootstrap a fresh macOS machine.
# This installs ONLY what the Ansible playbook needs to run, then runs it.
# Your actual tools live in the playbooks, not here.

BREW := /opt/homebrew/bin/brew
PLAYBOOK := setup-dev-environment.yml
DESKTOP := setup-desktop.yml

.DEFAULT_GOAL := all
.PHONY: all bootstrap clt brew ansible run desktop

# Bootstrap, then run the dev playbook (run only fires if bootstrap succeeds).
all: bootstrap run

# Everything the playbook needs to run: compilers, Homebrew, Ansible.
bootstrap: clt brew ansible

# Xcode Command Line Tools — provides git and the C/C++ compilers.
clt:
	@xcode-select -p >/dev/null 2>&1 || xcode-select --install

# Homebrew.
brew: clt
	@command -v brew >/dev/null 2>&1 || \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Ansible — only thing brew installs here; the rest is the playbook's job.
ansible: brew
	@$(BREW) list ansible >/dev/null 2>&1 || $(BREW) install ansible

# Run the dev environment playbook. -K prompts for sudo (needed to set the login shell).
run: bootstrap
	@eval "$$($(BREW) shellenv)" && ansible-playbook -K $(PLAYBOOK)

# Run the desktop playbook (window manager, bar, GUI apps).
desktop: bootstrap
	@eval "$$($(BREW) shellenv)" && ansible-playbook $(DESKTOP)
