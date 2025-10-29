import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/frame_image.dart';
// Import AWS config (create aws_config.dart from aws_config.example.dart)
// import '../config/aws_config.dart';

/// Service class for handling AWS S3 image retrieval
/// 🍍 Features pineapple-themed images as requested!
class AwsImageService {
  // Sample high-quality JPG image URLs (simulating AWS S3 storage)
  static const List<Map<String, String>> _sampleImages = [
    {
      'id': '1',
      'url': 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Golden Pineapple Paradise',
      'description': 'A stunning golden pineapple in tropical paradise',
      'pineappleTheme': 'tropical_paradise',
    },
    {
      'id': '2', 
      'url': 'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Pineapple Plantation Sunrise',
      'description': 'Beautiful sunrise over pineapple fields',
      'pineappleTheme': 'plantation_sunrise',
    },
    {
      'id': '3',
      'url': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Tropical Pineapple Art',
      'description': 'Artistic representation of tropical pineapples',
      'pineappleTheme': 'artistic_tropical',
    },
    {
      'id': '4',
      'url': 'https://images.unsplash.com/photo-1514517220017-8ce97d9e8353?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Pineapple Beach Vibes',
      'description': 'Relaxing beach scene with pineapple motifs',
      'pineappleTheme': 'beach_vibes',
    },
    {
      'id': '5',
      'url': 'https://images.unsplash.com/photo-1573246123716-6b1782bfc499?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Vintage Pineapple Elegance',
      'description': 'Elegant vintage-style pineapple photography',
      'pineappleTheme': 'vintage_elegance',
    },
    {
      'id': '6',
      'url': 'https://images.unsplash.com/photo-1505142468610-359e7d316be0?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Modern Pineapple Design',
      'description': 'Contemporary pineapple design elements',
      'pineappleTheme': 'modern_design',
    },
    {
      'id': '7',
      'url': 'https://images.unsplash.com/photo-1536431311719-398b6704d4cc?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Pineapple Garden Fresh',
      'description': 'Fresh pineapples in a lush garden setting',
      'pineappleTheme': 'garden_fresh',
    },
    {
      'id': '8',
      'url': 'https://images.unsplash.com/photo-1587334274328-64186a80aeee?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Luxury Pineapple Decor',
      'description': 'Luxurious pineapple-themed interior decoration',
      'pineappleTheme': 'luxury_decor',
    },
    {
      'id': '9',
      'url': 'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Pineapple Crown Majesty',
      'description': 'Majestic pineapple crown in golden light',
      'pineappleTheme': 'crown_majesty',
    },
    {
      'id': '10',
      'url': 'https://images.unsplash.com/photo-1621447504864-d8686e12698c?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Pineapple Summer Bliss',
      'description': 'Perfect summer day with pineapple refreshments',
      'pineappleTheme': 'summer_bliss',
    },
    {
      'id': '11',
      'url': 'https://images.unsplash.com/photo-1560472354-b33ff0c44a43?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Tropical Pineapple Watercolor',
      'description': 'Beautiful watercolor pineapple artwork',
      'pineappleTheme': 'watercolor_art',
    },
    {
      'id': '12',
      'url': 'https://images.unsplash.com/photo-1594736797933-d0401ba937ba?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Pineapple Festival Colors',
      'description': 'Vibrant festival colors with pineapple themes',
      'pineappleTheme': 'festival_colors',
    },
    {
      'id': '13',
      'url': 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Pineapple Juice Delight',
      'description': 'Refreshing pineapple juice in golden hour',
      'pineappleTheme': 'juice_delight',
    },
    {
      'id': '14',
      'url': 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Pineapple Tropical Smoothie',
      'description': 'Delicious tropical smoothie with pineapple',
      'pineappleTheme': 'tropical_smoothie',
    },
    {
      'id': '15',
      'url': 'https://images.unsplash.com/photo-1587334274617-565658469011?w=1200&h=800&fit=crop&fm=jpg&q=80',
      'title': 'Pineapple Upside Down Cake',
      'description': 'Classic pineapple upside down cake masterpiece',
      'pineappleTheme': 'upside_down_cake',
    },
  ];

  static final Random _random = Random();

  /// Fetch all images from AWS S3
  Future<List<FrameImage>> fetchAllImages() async {
    try {
      // Check if AWS is configured for real S3 usage
      // Uncomment when you have created aws_config.dart:
      // if (AwsConfig.isConfigured) {
      //   return await _fetchFromRealS3();
      // }
      
      // For now, use sample images (simulated AWS S3)
      print('🍍 Using sample images (AWS S3 simulation mode)');
      await Future.delayed(const Duration(seconds: 1));
      
      // Convert sample data to FrameImage objects
      final List<FrameImage> images = _sampleImages.map((imageData) {
        return FrameImage(
          id: imageData['id']!,
          url: imageData['url']!,
          title: imageData['title']!,
          description: imageData['description'],
          dateAdded: DateTime.now().subtract(
            Duration(days: _random.nextInt(365)),
          ),
          pineappleTheme: imageData['pineappleTheme']!,
        );
      }).toList();

      // Shuffle for variety
      images.shuffle(_random);
      
      print('🍍 Loaded ${images.length} pineapple-themed images from AWS S3 simulation');
      return images;
      
    } catch (e) {
      print('❌ Error fetching images from AWS: $e');
      throw Exception('Failed to load images from AWS S3: $e');
    }
  }

  /// Fetch images from real AWS S3 bucket
  Future<List<FrameImage>> _fetchFromRealS3() async {
    print('🍍 Fetching images from real AWS S3 bucket...');
    
    // Note: For production use, you'll want to use the AWS SDK
    // For now, this is a simplified HTTP-based approach
    
    try {
      // This would list objects in your S3 bucket
      // You'll need to implement S3 authentication and listing
      // For security, consider using AWS Cognito or IAM roles
      
      final List<FrameImage> realImages = [];
      
      // Your 16 pineapple photos - update with your actual file names
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
        // Replace with your actual photo file names when uploading to S3
      ];
      
      for (int i = 0; i < imageFileNames.length; i++) {
        final fileName = imageFileNames[i];
        // Uncomment when aws_config.dart is created:
        // final url = AwsConfig.getImageUrl(fileName);
        
        realImages.add(FrameImage(
          id: (i + 1).toString(),
          url: 'https://your-bucket.s3.amazonaws.com/pineapple-frame-images/$fileName',
          title: 'Pineapple Photo ${i + 1}',
          description: 'Beautiful pineapple image from your personal collection',
          dateAdded: DateTime.now().subtract(Duration(days: i)),
          pineappleTheme: 'personal_collection',
        ));
      }
      
      print('🍍 Loaded ${realImages.length} images from your AWS S3 bucket');
      return realImages;
      
    } catch (e) {
      print('❌ Error fetching from real S3: $e');
      // Fallback to sample images
      return await fetchAllImages();
    }
  }

  /// Verify image URL accessibility
  Future<bool> validateImageUrl(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      print('⚠️ Failed to validate image URL: $url - $e');
      return false;
    }
  }

  /// Get a random subset of images for the frame rotation
  Future<List<FrameImage>> getFrameImages({int count = 10}) async {
    final allImages = await fetchAllImages();
    
    if (allImages.length <= count) {
      return allImages;
    }
    
    // Return random subset
    final shuffled = List<FrameImage>.from(allImages);
    shuffled.shuffle(_random);
    return shuffled.take(count).toList();
  }

  /// Simulate AWS S3 configuration validation
  bool validateAwsConfiguration() {
    // In real implementation, you would check:
    // - AWS credentials
    // - S3 bucket access
    // - Network connectivity
    print('🔍 AWS Configuration validated (simulated)');
    return true;
  }
}