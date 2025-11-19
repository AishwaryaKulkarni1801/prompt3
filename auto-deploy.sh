#!/bin/bash

# =============================================================================
# AUTO-DEPLOY SCRIPT FOR FRONTEND PROJECTS (Angular/React/Vue/etc.)
# =============================================================================
# This script automatically commits, pushes, and triggers GitHub Pages deployment
# Works generically with any frontend framework using GitHub Actions
# 
# Usage: ./auto-deploy.sh [optional-commit-message]
# Example: ./auto-deploy.sh "Fix navigation bug"
# =============================================================================

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting auto-deployment process...${NC}"

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ Error: Not in a Git repository! Please run this from your project root.${NC}"
    exit 1
fi

# Check if there are any changes to commit
if [ -z "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}⚠️  No changes detected. Nothing to commit.${NC}"
    exit 0
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)
echo -e "${BLUE}📍 Current branch: ${CURRENT_BRANCH}${NC}"

# Use provided commit message or generate automatic one
if [ -z "$1" ]; then
    COMMIT_MESSAGE="Auto deploy: $(date '+%Y-%m-%d %H:%M:%S')"
else
    COMMIT_MESSAGE="$1"
fi

echo -e "${BLUE}📝 Commit message: ${COMMIT_MESSAGE}${NC}"

# Stage all changes
echo -e "${BLUE}📦 Staging all changes...${NC}"
git add .

# Check if there are staged changes
if [ -z "$(git diff --staged --name-only)" ]; then
    echo -e "${YELLOW}⚠️  No staged changes found.${NC}"
    exit 0
fi

# Show what's being committed
echo -e "${BLUE}📋 Files to be committed:${NC}"
git diff --staged --name-only | sed 's/^/  - /'

# Commit changes
echo -e "${BLUE}💾 Committing changes...${NC}"
git commit -m "$COMMIT_MESSAGE"

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Commit failed!${NC}"
    exit 1
fi

# Push to remote
echo -e "${BLUE}⬆️  Pushing to origin ${CURRENT_BRANCH}...${NC}"
git push origin "$CURRENT_BRANCH"

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Push failed!${NC}"
    exit 1
fi

# Get repository info for deployment URL
REMOTE_URL=$(git config --get remote.origin.url)
if [[ $REMOTE_URL == *"github.com"* ]]; then
    # Extract username and repo name from GitHub URL
    if [[ $REMOTE_URL == *".git" ]]; then
        REPO_INFO=$(echo $REMOTE_URL | sed 's/.*github\.com[:/]\([^/]*\)\/\([^.]*\)\.git.*/\1\/\2/')
    else
        REPO_INFO=$(echo $REMOTE_URL | sed 's/.*github\.com[:/]\([^/]*\)\/\(.*\)/\1\/\2/')
    fi
    USERNAME=$(echo $REPO_INFO | cut -d'/' -f1)
    REPO_NAME=$(echo $REPO_INFO | cut -d'/' -f2)
    
    echo -e "${GREEN}✅ Successfully pushed to GitHub!${NC}"
    echo -e "${BLUE}🔄 GitHub Actions workflow should now be triggered...${NC}"
    echo -e "${BLUE}📊 Monitor deployment: https://github.com/${USERNAME}/${REPO_NAME}/actions${NC}"
    echo -e "${BLUE}🌐 Your app will be available at: https://${USERNAME}.github.io/${REPO_NAME}/${NC}"
else
    echo -e "${GREEN}✅ Successfully pushed to remote!${NC}"
    echo -e "${YELLOW}⚠️  Could not determine GitHub Pages URL (not a GitHub repository)${NC}"
fi

echo -e "${GREEN}🎉 Auto-deployment completed successfully!${NC}"