# 🍍 Quick AWS S3 Setup for Your Photos

## Step 1: Create S3 Bucket
1. Go to [AWS S3 Console](https://s3.console.aws.amazon.com/)
2. Click "Create bucket"
3. **Bucket name**: `bruno-pineapple-photos-2024` (must be globally unique)
4. **Region**: `us-east-1` (or your preferred region)
5. **Block Public Access**: Uncheck "Block all public access" 
6. Click "Create bucket"

## Step 2: Upload Your Photos
1. Open your new bucket
2. Create folder: `pineapple-frame-images/`
3. Upload 10+ JPG photos to this folder
   - **Recommended**: Tropical, beach, food, travel photos
   - **Format**: .jpg or .jpeg only
   - **Size**: 1200x800 or higher resolution
   - **File size**: Under 5MB each

## Step 3: Set Bucket Policy
1. Go to bucket → Permissions → Bucket policy
2. Add this policy (replace `bruno-pineapple-photos-2024` with your bucket name):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::bruno-pineapple-photos-2024/pineapple-frame-images/*"
    }
  ]
}
```

## Step 4: Configure App
1. Copy `lib/config/aws_config.example.dart` to `lib/config/aws_config.dart`
2. Edit the new file with your settings:

```dart
class AwsConfig {
  static const String bucketName = 'bruno-pineapple-photos-2024';
  static const String region = 'us-east-1';
  static const String folderPath = 'pineapple-frame-images/';
  // ... rest stays the same for now
}
```

## Step 5: Update Image List
In `lib/services/aws_image_service.dart`, update the `_fetchFromRealS3()` method with your actual image file names:

```dart
final List<String> imageFileNames = [
  'beach-sunset.jpg',
  'tropical-paradise.jpg', 
  'pineapple-drink.jpg',
  // Add all your uploaded photo names here
];
```

## Step 6: Enable Real S3
Uncomment these lines in `lib/services/aws_image_service.dart`:

```dart
// Uncomment this:
import '../config/aws_config.dart';

// Uncomment this in fetchAllImages():
if (AwsConfig.isConfigured) {
  return await _fetchFromRealS3();
}
```

## Step 7: Test & Deploy
```bash
flutter run
git add .
git commit -m "🍍 Add real AWS S3 integration with personal photos"
git push
```

Your pineapple picture frame will now display your personal photos! 🍍📸