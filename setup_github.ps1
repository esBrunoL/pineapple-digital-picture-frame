# 🍍 Pineapple Digital Picture Frame - Quick GitHub Setup (PowerShell)
# This script helps you quickly set up your GitHub repository

Write-Host "🍍 Setting up Pineapple Digital Picture Frame on GitHub..." -ForegroundColor Yellow
Write-Host ""

# Check if git is initialized
if (!(Test-Path ".git")) {
    Write-Host "📦 Initializing git repository..." -ForegroundColor Cyan
    git init
} else {
    Write-Host "✅ Git repository already initialized" -ForegroundColor Green
}

# Check if there are uncommitted changes
$gitStatus = git status --porcelain
if ($gitStatus) {
    Write-Host "📝 Adding files to git..." -ForegroundColor Cyan
    git add .
    
    Write-Host "💾 Creating initial commit..." -ForegroundColor Cyan
    git commit -m "🍍 Initial commit: Pineapple Digital Picture Frame

✨ Features:
- Beautiful pineapple-themed digital picture frame  
- Auto-rotation every 10 seconds
- Pause/resume functionality
- Premium animated border with pineapple decorations
- AWS S3 integration ready
- Cross-platform Flutter app for Android, iOS, and Web"
} else {
    Write-Host "✅ No uncommitted changes found" -ForegroundColor Green
}

Write-Host ""
Write-Host "🎯 Next steps:" -ForegroundColor Yellow
Write-Host "1. Create a new repository on GitHub.com" -ForegroundColor White
Write-Host "2. Copy the repository URL" -ForegroundColor White
Write-Host "3. Run: git remote add origin YOUR_GITHUB_URL" -ForegroundColor Cyan
Write-Host "4. Run: git branch -M main" -ForegroundColor Cyan
Write-Host "5. Run: git push -u origin main" -ForegroundColor Cyan
Write-Host ""
Write-Host "📖 For detailed setup instructions, see: GITHUB_AWS_SETUP.md" -ForegroundColor Magenta
Write-Host ""
Write-Host "🍍 Your pineapple digital picture frame is ready for GitHub! 🍍" -ForegroundColor Yellow