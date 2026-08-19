#!/bin/bash

# Define the target directory where all repositories will be saved
TARGET_DIR="$HOME"

# List your repository URLs here (supports both HTTPS and SSH)
REPOSITORIES=(
    "https://github.com/spase-group/spase-scripts.git"
    "https://github.com/spase-group/spase-generate-pages.git"
    "https://github.com/hpde/NASA.git"
    "https://github.com/hpde/SMWG.git"
    "https://github.com/spase-group/spase-base-model.git"
    "https://github.com/spase-group/spase-model-tools.git"
    "https://github.com/spase-group/website.git"
    "https://github.com/spase-group/spase-model-tools-node.git"
)

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR" || exit 1

echo "Starting batch clone into: $TARGET_DIR"

# Loop through the array and clone each repository
for REPO in "${REPOSITORIES[@]}"; do
    # Extract the repository name from the URL for logging
    REPO_NAME=$(basename "$REPO" .git)
    
    if [ -d "$REPO_NAME" ]; then
        echo "Directory '$REPO_NAME' already exists. Skipping..."
    else
        echo "Cloning $REPO_NAME..."
        git clone "$REPO"
    fi
done

echo "All repositories processed!"