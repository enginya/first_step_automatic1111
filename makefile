# リポジトリのURL
REPO_URL = git@github.com:AUTOMATIC1111/stable-diffusion-webui.git

# クローン先のディレクトリ名
CLONE_DIR = automatic1111

# SSHキー関連
SSH_KEY_PATH = ~/.ssh/id_rsa_github
SSH_CONFIG_PATH = ~/.ssh/config
SSH_HOST_ALIAS = github
GITHUB_HOST = github.com

# デフォルトのターゲット
all: setup_ssh clone

# SSHキー作成ターゲット
setup_ssh:
	@echo "Checking if SSH key exists..."
	@if [ -f "$(SSH_KEY_PATH)" ]; then \
		echo "SSH key already exists at $(SSH_KEY_PATH). Skipping key generation."; \
	else \
		echo "Generating new SSH key..."; \
		ssh-keygen -t rsa -b 4096 -f $(SSH_KEY_PATH) -N ""; \
		echo "SSH key generated at $(SSH_KEY_PATH)."; \
	fi
	@echo "Checking if SSH config contains GitHub information..."
	@if grep -q "$(SSH_HOST_ALIAS)" $(SSH_CONFIG_PATH); then \
		echo "GitHub SSH config already exists. Skipping config addition."; \
	else \
		echo "Adding GitHub SSH config to $(SSH_CONFIG_PATH)..."; \
		echo "\nHost $(SSH_HOST_ALIAS)\n  HostName $(GITHUB_HOST)\n  IdentityFile $(SSH_KEY_PATH)\n  User git\n" >> $(SSH_CONFIG_PATH); \
		echo "GitHub SSH config added."; \
	fi

# クローンを実行するターゲット
clone:
	@echo "Cloning repository..."
	@if [ -d "$(CLONE_DIR)" ]; then \
		echo "Directory $(CLONE_DIR) already exists. Skipping clone."; \
	else \
		git clone $(REPO_URL) $(CLONE_DIR); \
	fi
	@echo "Clone completed."

# クリーンアップ用のターゲット
clean:
	@echo "Removing cloned repository..."
	@rm -rf $(CLONE_DIR)
	@echo "Cleanup completed."

.PHONY: all setup_ssh clone clean
