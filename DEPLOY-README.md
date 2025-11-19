# Auto-Deploy Scripts for Frontend Projects

This repository includes ready-to-use auto-deployment scripts that work with **Angular**, **React**, **Vue**, and other frontend frameworks for GitHub Pages deployment.

## 🚀 Quick Start

### For Your Current Project (Angular - prompt3)

**Windows (Command Prompt):**
```cmd
auto-deploy.bat
```

**Windows (PowerShell):**
```powershell
.\auto-deploy.ps1
```

**Linux/Mac (Bash):**
```bash
./auto-deploy.sh
```

### With Custom Commit Message

```cmd
auto-deploy.bat "Fix navigation bug"
```

```powershell
.\auto-deploy.ps1 "Add new feature"
```

```bash
./auto-deploy.sh "Update styling"
```

## 📋 What These Scripts Do

1. **✅ Check for changes** - Detects if there are any uncommitted changes
2. **📦 Stage all files** - Runs `git add .`
3. **💾 Commit with timestamp** - Auto-generates commit message with current date/time
4. **⬆️ Push to GitHub** - Pushes to your current branch
5. **🚀 Trigger deployment** - Automatically triggers GitHub Actions workflow
6. **📊 Show monitoring links** - Displays links to check deployment status

## 🔧 Generic Usage (Any Frontend Project)

These scripts work out-of-the-box with:

- **Angular** projects
- **React** projects  
- **Vue** projects
- **Next.js** projects
- **Vite** projects
- Any frontend framework with GitHub Actions CI/CD

### Prerequisites

1. Have a GitHub repository set up
2. Have a `.github/workflows/deploy.yml` or similar CI/CD workflow
3. Be in your project root directory

## 🎯 Your Current Setup

- **Repository**: https://github.com/AishwaryaKulkarni1801/prompt3
- **Branch**: main
- **Deployment URL**: https://aishwaryakulkarni1801.github.io/prompt3/
- **Actions Monitor**: https://github.com/AishwaryaKulkarni1801/prompt3/actions

## ⚡ Manual Commands (Alternative)

If you prefer running commands manually:

```bash
git add .
git commit -m "Auto deploy: $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main
```

**Windows PowerShell:**
```powershell
git add .
git commit -m "Auto deploy: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git push origin main
```

## 🛠️ Customization

### Custom Commit Messages
Pass a commit message as the first argument to any script:

```bash
./auto-deploy.sh "Feature: Add user authentication"
```

### Different Branch
The scripts automatically detect your current branch, but you can modify them if needed.

## 🌐 Framework-Specific Notes

### Angular
- Ensure your `angular.json` has the correct output path
- Build command should include `--base-href '/your-repo-name/'`

### React
- Ensure `package.json` has `"homepage": "https://username.github.io/repo-name"`
- Build command typically uses `npm run build`

### Vue
- Configure `publicPath` in `vue.config.js` for GitHub Pages
- Build command typically uses `npm run build`

## 🔍 Troubleshooting

- **"Not in a Git repository"**: Make sure you're in your project root
- **"No changes detected"**: All files are already committed
- **Push fails**: Check your Git credentials and network connection
- **Deployment fails**: Check GitHub Actions logs for specific errors

## 📝 License

These scripts are free to use and modify for any project.