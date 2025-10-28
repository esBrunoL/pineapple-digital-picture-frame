#!/bin/bash

# 🍍 Pineapple Digital Picture Frame - Quick GitHub Setup
# This script helps you quickly set up your GitHub repository

echo "🍍 Setting up Pineapple Digital Picture Frame on GitHub..."
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📦 Initializing git repository..."
    git init
else
    echo "✅ Git repository already initialized"
fi

# Check if there are uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo "📝 Adding files to git..."
    git add .
    
    echo "💾 Creating initial commit..."
    git commit -m "🍍 Initial commit: Pineapple Digital Picture Frame

✨ Features:
- Beautiful pineapple-themed digital picture frame  
- Auto-rotation every 10 seconds
- Pause/resume functionality
- Premium animated border with pineapple decorations
- AWS S3 integration ready
- Cross-platform Flutter app for Android, iOS, and Web"
else
    echo "✅ No uncommitted changes found"
fi

echo ""
echo "🎯 Next steps:"
echo "1. Create a new repository on GitHub.com"
echo "2. Copy the repository URL"
echo "3. Run: git remote add origin YOUR_GITHUB_URL"
echo "4. Run: git branch -M main"  
echo "5. Run: git push -u origin main"
echo ""
echo "📖 For detailed setup instructions, see: GITHUB_AWS_SETUP.md"
echo ""
echo "🍍 Your pineapple digital picture frame is ready for GitHub! 🍍"