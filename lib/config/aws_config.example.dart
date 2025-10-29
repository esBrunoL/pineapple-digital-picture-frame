/// AWS S3 Configuration for Pineapple Digital Picture Frame
/// 🍍 Configure your AWS credentials and bucket settings here
class AwsConfig {
  // AWS S3 Configuration (EXAMPLE - Replace with YOUR settings)
  static const String bucketName = 'bruno-pineapple-photos-2024'; // Your unique bucket name
  static const String region = 'us-east-1'; // Your AWS region
  static const String folderPath = 'pineapple-frame-images/'; // Folder inside bucket
  
  // For public bucket access (no credentials needed)
  static bool get isConfigured => 
    bucketName != 'your-bucket-name-here' && 
    bucketName.isNotEmpty;
  
  // Image constraints
  static const List<String> allowedExtensions = ['.jpg', '.jpeg'];
  static const int maxImageSizeBytes = 5 * 1024 * 1024; // 5MB max
  
  // S3 URL format for public access
  static String get baseUrl => 'https://$bucketName.s3.$region.amazonaws.com';
  
  /// Get full S3 URL for an image (public bucket)
  static String getImageUrl(String fileName) {
    return '$baseUrl/$folderPath$fileName';
  }
  
  /// Validate bucket configuration
  static void validateConfig() {
    if (!isConfigured) {
      throw Exception('AWS S3 not configured. Please update aws_config.dart with your bucket name.');
    }
  }
}