import 'package:flutter/material.dart';

void main() {
  runApp(const MinimalPineappleApp());
}

class MinimalPineappleApp extends StatelessWidget {
  const MinimalPineappleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pineapple Digital Picture Frame - Minimal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MinimalFrameScreen(),
    );
  }
}

class MinimalFrameScreen extends StatefulWidget {
  const MinimalFrameScreen({Key? key}) : super(key: key);

  @override
  State<MinimalFrameScreen> createState() => _MinimalFrameScreenState();
}

class _MinimalFrameScreenState extends State<MinimalFrameScreen> {
  int currentImageIndex = 0;
  
  // My 14 personal photos from AWS S3 tropical-repo bucket! 🍍✨
  // CORS is now configured - your personal photos will display!
  final List<String> personalPhotos = [
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(1).jpg',
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(2).jpg',
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(3).jpg',
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(4).jpg',
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(5).jpg',
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(6).jpg',
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(7).jpg',
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(8).jpg',
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(9).jpg',
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(10).JPG',
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(11).jpg',
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(12).jpg',
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(13).jpg',
    'https://tropical-repo.s3.us-east-2.amazonaws.com/pineapple-frame-images/photo%20(14).jpg',
  ];

  @override
  void initState() {
    super.initState();
    // Start rotation timer - change photo every 10 seconds
    _startPhotoRotation();
  }

  void _startPhotoRotation() {
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          currentImageIndex = (currentImageIndex + 1) % personalPhotos.length;
        });
        _startPhotoRotation(); // Schedule next rotation
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive sizing
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    
    // Use 80% of screen width, with responsive height
    final frameWidth = screenWidth * 0.8;
    final frameHeight = frameWidth * 0.7; // 16:11.2 aspect ratio for photo frames
    
    // Ensure frame doesn't exceed 80% of screen height
    final maxFrameHeight = screenHeight * 0.8;
    final finalFrameWidth = frameHeight > maxFrameHeight ? maxFrameHeight / 0.7 : frameWidth;
    final finalFrameHeight = frameHeight > maxFrameHeight ? maxFrameHeight : frameHeight;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pineapple Picture Frame
            Container(
          width: finalFrameWidth,
          height: finalFrameHeight,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFD700), // Gold
                Color(0xFFFF8C00), // Dark Orange
                Color(0xFFFF6347), // Tomato
                Color(0xFFFF1493), // Deep Pink
                Color(0xFF9932CC), // Dark Orchid
                Color(0xFF4B0082), // Indigo
                Color(0xFF228B22), // Forest Green
              ],
            ),
            borderRadius: BorderRadius.circular(finalFrameWidth * 0.05), // Responsive border radius
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: finalFrameWidth * 0.04, // Responsive shadow blur
                offset: Offset(0, finalFrameWidth * 0.02), // Responsive shadow offset
              ),
            ],
          ),
          child: Container(
            margin: EdgeInsets.all(finalFrameWidth * 0.038), // Responsive margin (15px at 400px width)
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(finalFrameWidth * 0.025), // Responsive inner radius
              image: DecorationImage(
                image: NetworkImage(
                  personalPhotos[currentImageIndex],
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Responsive Pineapple corners
                Positioned(
                  top: finalFrameWidth * 0.02,
                  left: finalFrameWidth * 0.02,
                  child: Container(
                    width: finalFrameWidth * 0.08, // Responsive size (32px at 400px width)
                    height: finalFrameWidth * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(finalFrameWidth * 0.04),
                    ),
                    child: Center(
                      child: Text('🍍', style: TextStyle(fontSize: finalFrameWidth * 0.04)), // Responsive font size
                    ),
                  ),
                ),
                Positioned(
                  top: finalFrameWidth * 0.02,
                  right: finalFrameWidth * 0.02,
                  child: Container(
                    width: finalFrameWidth * 0.08,
                    height: finalFrameWidth * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(finalFrameWidth * 0.04),
                    ),
                    child: Center(
                      child: Text('🍍', style: TextStyle(fontSize: finalFrameWidth * 0.04)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: finalFrameWidth * 0.02,
                  left: finalFrameWidth * 0.02,
                  child: Container(
                    width: finalFrameWidth * 0.08,
                    height: finalFrameWidth * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(finalFrameWidth * 0.04),
                    ),
                    child: Center(
                      child: Text('🍍', style: TextStyle(fontSize: finalFrameWidth * 0.04)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: finalFrameWidth * 0.02,
                  right: finalFrameWidth * 0.02,
                  child: Container(
                    width: finalFrameWidth * 0.08,
                    height: finalFrameWidth * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(finalFrameWidth * 0.04),
                    ),
                    child: Center(
                      child: Text('🍍', style: TextStyle(fontSize: finalFrameWidth * 0.04)),
                    ),
                  ),
                ),

              ],
            ),
          ),
            ),
            // Spacing between frame and text
            SizedBox(height: finalFrameWidth * 0.06), // Responsive spacing
            // Title below the frame
            Text(
              'My tropical memories',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: finalFrameWidth * 0.04, // Responsive font size
                fontWeight: FontWeight.w300, // Light weight for elegant look
                letterSpacing: 1.2, // Slight letter spacing
              ),
            ),
          ],
        ),
      ),
    );
  }
}