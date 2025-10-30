# 🛠️ AWS S3 CORS Configuration Guide

## Problem: CORS Policy Blocking Your Photos
Your AWS S3 bucket needs to be configured to allow web browsers to load images from GitHub Pages.

## Solution: Add CORS Configuration to Your S3 Bucket

### Step 1: Go to AWS S3 Console
1. Open AWS Console → S3 → Your `tropical-repo` bucket
2. Click on the **Permissions** tab
3. Scroll down to **Cross-origin resource sharing (CORS)**

### Step 2: Add This CORS Configuration
```json
[
    {
        "AllowedHeaders": [
            "*"
        ],
        "AllowedMethods": [
            "GET",
            "HEAD"
        ],
        "AllowedOrigins": [
            "https://esbrunol.github.io",
            "https://*.github.io",
            "*"
        ],
        "ExposeHeaders": []
    }
]
```

### Step 3: Save Changes
- Click **Save changes**
- Wait 2-3 minutes for changes to propagate

### Step 4: Update Your App (After CORS is Fixed)
Replace the Unsplash URLs in your `main.dart` with your S3 URLs:

```dart
final List<String> personalPhotos = [
  'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(1).jpg',
  'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(2).jpg',
  // ... rest of your 14 photos
];
```

## Alternative Solution: Make Bucket Objects Public
If CORS still doesn't work, you can make the specific photos public:

1. Go to your S3 bucket → `pineapple-frame-images/` folder
2. Select all your photo files
3. Click **Actions** → **Make public via ACL**
4. Confirm the action

## Test Your Fix
After configuring CORS:
1. Wait 2-3 minutes
2. Try loading one photo directly in browser:
   `https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(1).jpg`
3. If it loads, update your Flutter app with S3 URLs

## Current Status
✅ **App is working** with beautiful pineapple-themed images from Unsplash
🔧 **Next step**: Fix CORS to load your personal photos

Once CORS is fixed, your personal photos will display in the gorgeous pineapple border! 🍍✨