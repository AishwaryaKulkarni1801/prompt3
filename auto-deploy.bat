@echo off
REM =============================================================================
REM AUTO-DEPLOY SCRIPT FOR FRONTEND PROJECTS (Angular/React/Vue/etc.) - WINDOWS
REM =============================================================================
REM This script automatically commits, pushes, and triggers GitHub Pages deployment
REM Works generically with any frontend framework using GitHub Actions
REM 
REM Usage: auto-deploy.bat [optional-commit-message]
REM Example: auto-deploy.bat "Fix navigation bug"
REM =============================================================================

echo 🚀 Starting auto-deployment process...

REM Check if we're in a git repository
if not exist ".git" (
    echo ❌ Error: Not in a Git repository! Please run this from your project root.
    exit /b 1
)

REM Check if there are any changes to commit
for /f %%i in ('git status --porcelain 2^>nul') do set HAS_CHANGES=1
if not defined HAS_CHANGES (
    echo ⚠️  No changes detected. Nothing to commit.
    exit /b 0
)

REM Get current branch
for /f "tokens=*" %%i in ('git branch --show-current') do set CURRENT_BRANCH=%%i
echo 📍 Current branch: %CURRENT_BRANCH%

REM Use provided commit message or generate automatic one
if "%~1"=="" (
    for /f "tokens=*" %%i in ('powershell -command "Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"') do set TIMESTAMP=%%i
    set COMMIT_MESSAGE=Auto deploy: !TIMESTAMP!
) else (
    set COMMIT_MESSAGE=%~1
)

echo 📝 Commit message: %COMMIT_MESSAGE%

REM Stage all changes
echo 📦 Staging all changes...
git add .

REM Check if there are staged changes
for /f %%i in ('git diff --staged --name-only 2^>nul') do set HAS_STAGED=1
if not defined HAS_STAGED (
    echo ⚠️  No staged changes found.
    exit /b 0
)

REM Show what's being committed
echo 📋 Files to be committed:
git diff --staged --name-only

REM Commit changes
echo 💾 Committing changes...
git commit -m "%COMMIT_MESSAGE%"
if %errorlevel% neq 0 (
    echo ❌ Commit failed!
    exit /b 1
)

REM Push to remote
echo ⬆️  Pushing to origin %CURRENT_BRANCH%...
git push origin "%CURRENT_BRANCH%"
if %errorlevel% neq 0 (
    echo ❌ Push failed!
    exit /b 1
)

REM Get repository info for deployment URL
for /f "tokens=*" %%i in ('git config --get remote.origin.url') do set REMOTE_URL=%%i

REM Extract GitHub info if it's a GitHub repository
echo %REMOTE_URL% | find "github.com" >nul
if %errorlevel% equ 0 (
    REM Simple extraction for common GitHub URL patterns
    echo ✅ Successfully pushed to GitHub!
    echo 🔄 GitHub Actions workflow should now be triggered...
    echo 📊 Monitor deployment at GitHub Actions tab
    echo 🌐 Your app will be available at GitHub Pages once deployed
) else (
    echo ✅ Successfully pushed to remote!
    echo ⚠️  Could not determine GitHub Pages URL (not a GitHub repository)
)

echo 🎉 Auto-deployment completed successfully!
pause