# 🍍 Quick AWS S3 Setup for Your Photos

## Step 1: Create S3 Bucket
1. Go to [AWS S3 Console](https://s3.console.aws.amazon.com/)
2. ✅ "Create bucket" - DONE
3. **✅ Bucket name**: `tropical-repo` (configured!)
4. **✅ Region**: `us-east-1` (set!)
5. **✅ Block Public Access**: Unchecked (done!)
6. ✅ Bucket created successfully!

## Step 2: Upload Your 16 Photos
1. Open your new bucket
2. Create folder: `pineapple-frame-images/`
3. Upload your 16 JPG photos to this folder
   - **Naming**: `pineapple-photo-01.jpg` through `pineapple-photo-16.jpg` (or your preferred names)
   - **Recommended**: Tropical, beach, food, travel, pineapple-themed photos
   - **Format**: .jpg or .jpeg only
   - **Size**: 1200x800 or higher resolution
   - **File size**: Under 5MB each
   - **Total time**: With 16 photos, each rotation cycle will be 2 minutes 40 seconds (16 × 10 seconds)

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
      "Resource": "arn:aws:s3:::tropical-repo/pineapple-frame-images/*"
    }
  ]
}
```
**✅ This matches your bucket policy perfectly!**

## Step 4: Configure App
1. Copy `lib/config/aws_config.example.dart` to `lib/config/aws_config.dart`
2. Edit the new file with your settings:

```dart
class AwsConfig {
  static const String bucketName = 'tropical-repo'; // ✅ CONFIGURED!
  static const String region = 'us-east-1';
  static const String folderPath = 'pineapple-frame-images/';
  // ✅ Already configured in your app!
}
```

## Step 5: Update Image List
In `lib/services/aws_image_service.dart`, update the `_fetchFromRealS3()` method with your actual image file names:

```dart
final List<String> imageFileNames = [
  'pineapple-photo-01.jpg',
  'pineapple-photo-02.jpg',
  'pineapple-photo-03.jpg',
  'pineapple-photo-04.jpg',
  'pineapple-photo-05.jpg',
  'pineapple-photo-06.jpg',
  'pineapple-photo-07.jpg',
  'pineapple-photo-08.jpg',
  'pineapple-photo-09.jpg',
  'pineapple-photo-10.jpg',
  'pineapple-photo-11.jpg',
  'pineapple-photo-12.jpg',
  'pineapple-photo-13.jpg',
  'pineapple-photo-14.jpg',
  'pineapple-photo-15.jpg',
  'pineapple-photo-16.jpg',
  // Update with your actual photo file names
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