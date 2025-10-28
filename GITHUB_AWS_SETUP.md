# 🍍 GitHub Setup & AWS S3 Integration Guide

This guide will help you publish your Pineapple Digital Picture Frame to GitHub and connect it to your AWS S3 storage for real photos.

## 📚 **Step 1: Create GitHub Repository**

### 1.1 Initialize Git Repository

Open PowerShell in your project directory and run:

```powershell
cd "c:\Users\bruno\Documents\mobileApp\virtualPortrait"

# Initialize git repository
git init

# Add all files to staging
git add .

# Make initial commit
git commit -m "🍍 Initial commit: Pineapple Digital Picture Frame

✨ Features:
- Beautiful pineapple-themed digital picture frame
- Auto-rotation every 10 seconds
- Pause/resume functionality
- Premium animated border with pineapple decorations
- AWS S3 integration (currently simulated)
- Cross-platform Flutter app for Android, iOS, and Web"
```

### 1.2 Create GitHub Repository

1. **Go to GitHub.com** and sign in
2. **Click "New Repository" (green button)**
3. **Repository Settings:**
   - **Name**: `pineapple-digital-picture-frame`
   - **Description**: `🍍 Beautiful pineapple-themed digital picture frame with AWS cloud storage and automatic rotation`
   - **Visibility**: Choose Public (to show on your profile) or Private
   - **Don't** initialize with README (we already have one)

4. **Copy the repository URL** (will look like: `https://github.com/yourusername/pineapple-digital-picture-frame.git`)

### 1.3 Connect Local Repository to GitHub

```powershell
# Add GitHub as remote origin (replace with your actual GitHub URL)
git remote add origin https://github.com/YOUR_USERNAME/pineapple-digital-picture-frame.git

# Push to GitHub
git branch -M main
git push -u origin main
```

### 1.4 Add GitHub Pages Support (Optional - for Web Demo)

To host a web demo of your app:

1. **In your GitHub repository**, go to Settings → Pages
2. **Source**: Deploy from a branch
3. **Branch**: main / docs (you'll need to build for web first)

## ☁️ **Step 2: AWS S3 Setup for Real Photos**

### 2.1 Create AWS S3 Bucket

1. **Sign in to AWS Console**: https://console.aws.amazon.com/
2. **Go to S3 Service**
3. **Create New Bucket:**
   - **Name**: `your-pineapple-images-bucket` (must be globally unique)
   - **Region**: Choose closest to your users (e.g., `us-east-1`)
   - **Public Access**: Block all public access (we'll configure properly)

### 2.2 Upload Your Pineapple Images

1. **In your S3 bucket**, create a folder: `pineapple-frame-images/`
2. **Upload JPG images** to this folder:
   - **Format**: Only .jpg or .jpeg files
   - **Size**: Recommended 1200x800 pixels or higher
   - **File Size**: Keep under 5MB each for best performance
   - **Naming**: Use descriptive names like `tropical-paradise-1.jpg`

### 2.3 Configure S3 Bucket Policy

Your bucket needs public read access for the images. Add this policy:

**Bucket Policy** (replace `your-pineapple-images-bucket` with your bucket name):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::your-pineapple-images-bucket/pineapple-frame-images/*"
    }
  ]
}
```

### 2.4 Create IAM User for App Access

1. **Go to IAM Service** in AWS Console
2. **Create User**: `pineapple-frame-app`
3. **Attach Policy**: Create custom policy:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::your-pineapple-images-bucket",
                "arn:aws:s3:::your-pineapple-images-bucket/*"
            ]
        }
    ]
}
```

4. **Create Access Key** for this user and save:
   - Access Key ID
   - Secret Access Key

## 🔧 **Step 3: Configure App for AWS S3**

### 3.1 Create AWS Configuration File

```powershell
# Copy the example config file
copy "lib\config\aws_config.example.dart" "lib\config\aws_config.dart"
```

### 3.2 Edit AWS Configuration

Open `lib/config/aws_config.dart` and update with your AWS details:

```dart
class AwsConfig {
  // Your actual AWS S3 Configuration
  static const String bucketName = 'your-actual-bucket-name';
  static const String region = 'us-east-1'; // Your chosen region
  static const String accessKeyId = 'AKIA...'; // Your access key
  static const String secretAccessKey = 'your-secret-key'; // Your secret
  
  // Your folder path within bucket
  static const String folderPath = 'pineapple-frame-images/';
  
  // ... rest of the configuration
}
```

### 3.3 Enable Real AWS Integration

In `lib/services/aws_image_service.dart`, uncomment the AWS import and configuration lines:

```dart
// Uncomment this line:
import '../config/aws_config.dart';

// In fetchAllImages method, uncomment:
if (AwsConfig.isConfigured) {
  return await _fetchFromRealS3();
}
```

### 3.4 Update Real S3 Method

Add your actual image file names in the `_fetchFromRealS3()` method:

```dart
final List<String> imageFileNames = [
  'tropical-paradise-1.jpg',
  'golden-pineapple-2.jpg',  
  'beach-vibes-3.jpg',
  // Add all your uploaded image file names
];
```

## 🔒 **Step 4: Security Best Practices**

### 4.1 Environment Variables (Production)

For production apps, use environment variables instead of hardcoded credentials:

Create `.env` file (already in .gitignore):
```
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_BUCKET_NAME=your_bucket_name
AWS_REGION=us-east-1
```

### 4.2 Never Commit Credentials

**Important**: Never commit your `aws_config.dart` file with real credentials!

```powershell
# Make sure aws_config.dart is in .gitignore
echo "lib/config/aws_config.dart" >> .gitignore
```

## 🌐 **Step 5: Deploy Web Version**

### 5.1 Build for Web

```powershell
# Build web version
flutter build web --release

# The files will be in build/web/
```

### 5.2 Deploy to GitHub Pages

Option 1: **Manual Upload**
- Copy contents of `build/web/` to `docs/` folder
- Commit and push to GitHub
- Enable GitHub Pages from `docs/` folder

Option 2: **GitHub Actions** (Advanced)
- Create `.github/workflows/deploy.yml` for automatic deployment

## 📱 **Step 6: Build Mobile Apps**

### 6.1 Android APK

```powershell
# Build Android APK
flutter build apk --release

# APK location: build/app/outputs/flutter-apk/app-release.apk
```

### 6.2 iOS App (macOS only)

```powershell
# Build iOS app
flutter build ios --release

# Open in Xcode for signing and distribution
open ios/Runner.xcworkspace
```

## 🎯 **Step 7: Test Everything**

### 7.1 Test AWS Integration

```powershell
# Run app and check console for:
flutter run

# Look for these messages:
# 🍍 Fetching images from real AWS S3 bucket...
# 🍍 Loaded X images from your AWS S3 bucket
```

### 7.2 Verify Image Loading

1. **App launches** with your custom images
2. **Images rotate** every 10 seconds
3. **Image quality** is high resolution
4. **No errors** in console about missing images

## 🏆 **Step 8: Share Your Project**

### 8.1 Update Repository Description

Add these to your GitHub repository:

**Topics/Tags**: `flutter`, `dart`, `aws`, `s3`, `digital-picture-frame`, `pineapple`, `mobile-app`, `cross-platform`

**README Badges**:
```markdown
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![AWS](https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
```

### 8.2 Create Release

1. **Go to your GitHub repo** → Releases
2. **Create new release**:
   - **Tag**: `v1.0.0`
   - **Title**: `🍍 Pineapple Digital Picture Frame v1.0.0`
   - **Description**: Include features and screenshots
3. **Attach APK file** for easy download

### 8.3 Add Screenshots

Create a `screenshots/` folder and add:
- App running with your images
- Pineapple border showcase
- Control panel in action
- Different device sizes

---

## 🎉 **Congratulations!**

You now have:
- ✅ **Professional GitHub repository** with your pineapple picture frame
- ✅ **Real AWS S3 integration** with your personal photos
- ✅ **Web demo** (if using GitHub Pages)
- ✅ **Mobile app builds** for Android and iOS
- ✅ **Secure credential management**

**Your pineapple digital picture frame is now live and showcasing your personal tropical memories! 🍍✨**

---

## 📞 **Need Help?**

If you encounter issues:

1. **Check AWS Console** for bucket permissions
2. **Verify image URLs** are publicly accessible
3. **Check Flutter console** for detailed error messages
4. **Test with sample images** first before switching to S3

Your beautiful pineapple digital picture frame is ready to impress with your personal photo collection! 🍍