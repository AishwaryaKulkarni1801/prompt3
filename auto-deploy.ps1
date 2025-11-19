# =============================================================================
# AUTO-DEPLOY SCRIPT FOR FRONTEND PROJECTS (Angular/React/Vue/etc.) - POWERSHELL
# =============================================================================
# This script automatically commits, pushes, and triggers GitHub Pages deployment
# Works generically with any frontend framework using GitHub Actions
# 
# Usage: .\auto-deploy.ps1 [optional-commit-message]
# Example: .\auto-deploy.ps1 "Fix navigation bug"
# =============================================================================

param(
    [string]$CommitMessage = ""
)

Write-Host "🚀 Starting auto-deployment process..." -ForegroundColor Blue

# Check if we're in a git repository
if (-not (Test-Path ".git")) {
    Write-Host "❌ Error: Not in a Git repository! Please run this from your project root." -ForegroundColor Red
    exit 1
}

# Check if there are any changes to commit
$hasChanges = git status --porcelain
if (-not $hasChanges) {
    Write-Host "⚠️  No changes detected. Nothing to commit." -ForegroundColor Yellow
    exit 0
}

# Get current branch
$currentBranch = git branch --show-current
Write-Host "📍 Current branch: $currentBranch" -ForegroundColor Blue

# Use provided commit message or generate automatic one
if ([string]::IsNullOrEmpty($CommitMessage)) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $CommitMessage = "Auto deploy: $timestamp"
}

Write-Host "📝 Commit message: $CommitMessage" -ForegroundColor Blue

# Stage all changes
Write-Host "📦 Staging all changes..." -ForegroundColor Blue
git add .

# Check if there are staged changes
$stagedChanges = git diff --staged --name-only
if (-not $stagedChanges) {
    Write-Host "⚠️  No staged changes found." -ForegroundColor Yellow
    exit 0
}

# Show what's being committed
Write-Host "📋 Files to be committed:" -ForegroundColor Blue
$stagedChanges | ForEach-Object { Write-Host "  - $_" }

# Commit changes
Write-Host "💾 Committing changes..." -ForegroundColor Blue
git commit -m "$CommitMessage"
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Commit failed!" -ForegroundColor Red
    exit 1
}

# Push to remote
Write-Host "⬆️  Pushing to origin $currentBranch..." -ForegroundColor Blue
git push origin "$currentBranch"
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Push failed!" -ForegroundColor Red
    exit 1
}

# Get repository info for deployment URL
$remoteUrl = git config --get remote.origin.url

if ($remoteUrl -match "github\.com") {
    # Extract username and repo name from GitHub URL
    if ($remoteUrl -match "github\.com[:/]([^/]+)/([^.]+)(?:\.git)?") {
        $username = $matches[1]
        $repoName = $matches[2]
        
        Write-Host "✅ Successfully pushed to GitHub!" -ForegroundColor Green
        Write-Host "🔄 GitHub Actions workflow should now be triggered..." -ForegroundColor Blue
        Write-Host "📊 Monitor deployment: https://github.com/$username/$repoName/actions" -ForegroundColor Blue
        Write-Host "🌐 Your app will be available at: https://$username.github.io/$repoName/" -ForegroundColor Blue
    } else {
        Write-Host "✅ Successfully pushed to GitHub!" -ForegroundColor Green
        Write-Host "🔄 GitHub Actions workflow should now be triggered..." -ForegroundColor Blue
    }
} else {
    Write-Host "✅ Successfully pushed to remote!" -ForegroundColor Green
    Write-Host "⚠️  Could not determine GitHub Pages URL (not a GitHub repository)" -ForegroundColor Yellow
}

Write-Host "🎉 Auto-deployment completed successfully!" -ForegroundColor Green