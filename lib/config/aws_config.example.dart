/// AWS S3 Configuration for Pineapple Digital Picture Frame
/// 🍍 Configure your AWS credentials and bucket settings here
class AwsConfig {
  // AWS S3 Configuration
  static const String bucketName = 'your-pineapple-images-bucket';
  static const String region = 'us-east-1'; // Change to your preferred region
  static const String accessKeyId = 'YOUR_ACCESS_KEY_ID';
  static const String secretAccessKey = 'YOUR_SECRET_ACCESS_KEY';
  
  // Optional: Folder path within bucket
  static const String folderPath = 'pineapple-frame-images/';
  
  // Image constraints
  static const List<String> allowedExtensions = ['.jpg', '.jpeg'];
  static const int maxImageSizeBytes = 5 * 1024 * 1024; // 5MB max
  
  // S3 URL format
  static String get baseUrl => 'https://$bucketName.s3.$region.amazonaws.com';
  
  /// Get full S3 URL for an image
  static String getImageUrl(String fileName) {
    return '$baseUrl/$folderPath$fileName';
  }
  
  /// Validate if this is a real AWS configuration
  static bool get isConfigured {
    return accessKeyId != 'YOUR_ACCESS_KEY_ID' && 
           secretAccessKey != 'YOUR_SECRET_ACCESS_KEY' &&
           bucketName != 'your-pineapple-images-bucket';
  }
}