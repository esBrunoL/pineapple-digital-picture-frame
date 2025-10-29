# 🍍 AWS S3 Setup Instructions - Replace YOUR bucket name!

## IMPORTANT: Update Your AWS Configuration

**✅ CONFIGURED! Your bucket `tropical-repo` is now connected!**

### ~~Step 1: Edit `lib/config/aws_config.dart`~~ ✅ DONE

~~Find this line (around line 6):~~
```dart
static const String bucketName = 'tropical-repo'; // ✅ CONFIGURED!
```

**✅ Your S3 bucket name is already set to `tropical-repo`!**

### Step 2: Create Your S3 Bucket & Upload Photos

1. **Go to AWS S3 Console**: https://s3.console.aws.amazon.com/
2. **✅ Bucket Created**: 
   - Name: `tropical-repo` ✅ DONE
   - Region: `us-east-1` ✅ DONE
   - **Unchecked** "Block all public access" ✅ DONE
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

**✅ Updated for your bucket `tropical-repo`!**

### Step 4: Ready to Upload Photos! 📸

Now just upload your 16 photos to the `pineapple-frame-images/` folder in your `tropical-repo` bucket, and your pineapple frame will automatically load YOUR personal photos instead of the sample images!

---

**Current Status**: The app is configured to use sample images until you update the bucket name and upload your photos. 🍍✨