#!/bin/bash

#############################
##### Homebrew packages #####
#############################

# Programming languages
brew install "openjdk@25"
brew install "node@24"
brew install "python@3.14"

# Package managers
brew install "maven"
brew install "uv"

# Developer tools
brew install "neovim"
brew install "tmux"
brew install "difftastic"
brew install "jq"
brew install "fd"
brew install "ripgrep"
brew install "wget"
brew install "fzf"
brew install "postgresql@17"
brew install "chafa"

# Linters 
brew install "ruff"

# Formatters
brew install "stylua"

# Type-checkers and language servers
brew install "jdtls"
brew install "pyright"
brew install "lua-language-server"
brew install "typescript-language-server"
brew install "tailwindcss-language-server"
brew install "hashicorp/tap/terraform-ls"

##########################
##### Java LSP setup #####
##########################

# Download lombok.jar if not already present
LOMBOK_PATH="$HOME/.local/share/java/lombok.jar"
LOMBOK_VERSION="1.18.42"

if [ ! -f "$LOMBOK_PATH" ]; then
    echo "Downloading lombok.jar..."
    mkdir -p "$HOME/.local/share/java"
    curl -L -o "$LOMBOK_PATH" "https://projectlombok.org/downloads/lombok-$LOMBOK_VERSION.jar"
    echo "lombok.jar downloaded to $LOMBOK_PATH"
else
    echo "lombok.jar already exists at $LOMBOK_PATH"
fi

OPENJDK_SYMLINK="/Library/Java/JavaVirtualMachines/openjdk-25.jdk"
OPENJDK_TARGET="/opt/homebrew/opt/openjdk@25/libexec/openjdk.jdk"

if [ ! -L "$OPENJDK_SYMLINK" ]; then
    echo "Creating symlink to use Homebrew's installation of Java instead of the system version..."
    sudo ln -sfn "$OPENJDK_TARGET" "$OPENJDK_SYMLINK"
    echo "Java symlink created at $OPENJDK_SYMLINK"
else
    echo "Java symlink already exists at $OPENJDK_SYMLINK"
fi
