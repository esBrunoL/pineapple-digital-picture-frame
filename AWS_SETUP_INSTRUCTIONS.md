# 🍍 AWS S3 Setup Instructions - Replace YOUR bucket name!

## IMPORTANT: Update Your AWS Configuration

**You need to update ONE line in the code before your photos will work:**

### Step 1: Edit `lib/config/aws_config.dart`

Find this line (around line 6):
```dart
static const String bucketName = 'bruno-pineapple-photos-2024'; // Your S3 bucket name
```

**Replace `bruno-pineapple-photos-2024` with YOUR actual S3 bucket name!**

### Step 2: Create Your S3 Bucket & Upload Photos

1. **Go to AWS S3 Console**: https://s3.console.aws.amazon.com/
2. **Create bucket**: 
   - Name: `your-unique-bucket-name-2024` (choose your own!)
   - Region: `us-east-1` (or your preferred region)
   - **Uncheck** "Block all public access" ✅
3. **Create folder**: `pineapple-frame-images/`
4. **Upload your 16 photos**: Name them `pineapple-photo-01.jpg` through `pineapple-photo-16.jpg`

### Step 3: Set Bucket Policy (Make Photos Public)

In your bucket → Permissions → Bucket policy → Add this JSON:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::YOUR-BUCKET-NAME-HERE/pineapple-frame-images/*"
    }
  ]
}
```

**Replace `YOUR-BUCKET-NAME-HERE` with your actual bucket name!**

### Step 4: Test Your Setup

After updating the bucket name in the code and uploading your photos, your pineapple frame will automatically load YOUR personal photos instead of the sample images!

---

**Current Status**: The app is configured to use sample images until you update the bucket name and upload your photos. 🍍✨