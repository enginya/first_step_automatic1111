# リポジトリのURL
REPO_URL = git@github.com:AUTOMATIC1111/stable-diffusion-webui.git

# クローン先のディレクトリ名
CLONE_DIR = automatic1111

# デフォルトのターゲット
all: clone

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

.PHONY: all clone clean