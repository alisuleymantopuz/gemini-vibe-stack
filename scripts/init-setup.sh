#!/bin/bash

# Gemini-Vibe-Stack Initialization Script
# Handles permissions and environment setup for zero-config startup.

set -e

echo "🚀 Initializing Gemini-Vibe-Stack..."

# 1. Environment Setup
if [ ! -f .env ]; then
    echo "Creating .env file from .env.example..."
    cp .env.example .env
else
    echo ".env file already exists. Skipping creation."
fi

# 2. UID/GID Mapping
CURRENT_UID=$(id -u)
CURRENT_GID=$(id -g)

# Update UID/GID in .env
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' "s/^UID=.*/UID=$CURRENT_UID/" .env
  sed -i '' "s/^GID=.*/GID=$CURRENT_GID/" .env
else
  sed -i "s/^UID=.*/UID=$CURRENT_UID/" .env
  sed -i "s/^GID=.*/GID=$CURRENT_GID/" .env
fi

echo "✅ Updated .env with current UID ($CURRENT_UID) and GID ($CURRENT_GID)."

# 3. Directory Permissions
echo "Setting permissions for workspaces..."
mkdir -p repos secrets agents/gemini
# Ensure current user owns the directories
# Docker containers will map this UID/GID so write access is preserved.

# 4. Secret Management (Root-to-Node)
# Example: If a key exists in environment, write it to secrets file for agents
if [ ! -z "$GEMINI_API_KEY" ]; then
    echo "Testing GEMINI_API_KEY presence... OK"
    # In a real scenario, we might write this to a secure file if needed by non-env-aware tools
    # echo "$GEMINI_API_KEY" > secrets/gemini_key
    # chmod 600 secrets/gemini_key
fi

echo "🎉 Setup complete! Run 'docker-compose up -d' to start the stack."
