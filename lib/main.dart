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
  
  // Beautiful pineapple-themed photos (CORS-friendly) 🍍✨
  // Once you fix AWS CORS, replace these with your S3 URLs
  final List<String> personalPhotos = [
    'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=800&h=600&fit=crop&fm=jpg&q=80', // Golden Pineapple Paradise
    'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=800&h=600&fit=crop&fm=jpg&q=80', // Pineapple Plantation Sunrise
    'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800&h=600&fit=crop&fm=jpg&q=80', // Tropical Pineapple Art
    'https://images.unsplash.com/photo-1514517220017-8ce97d9e8353?w=800&h=600&fit=crop&fm=jpg&q=80', // Pineapple Beach Vibes
    'https://images.unsplash.com/photo-1573246123716-6b1782bfc499?w=800&h=600&fit=crop&fm=jpg&q=80', // Vintage Pineapple Elegance
    'https://images.unsplash.com/photo-1505142468610-359e7d316be0?w=800&h=600&fit=crop&fm=jpg&q=80', // Fresh Pineapple Slices
    'https://images.unsplash.com/photo-1589820296156-2454bb8a6ad1?w=800&h=600&fit=crop&fm=jpg&q=80', // Tropical Pineapple Garden
    'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=800&h=600&fit=crop&fm=jpg&q=80', // Pineapple Tropical Smoothie
    'https://images.unsplash.com/photo-1587334274617-565658469011?w=800&h=600&fit=crop&fm=jpg&q=80', // Pineapple Upside Down Cake
    'https://images.unsplash.com/photo-1594736797933-d0401ba937ba?w=800&h=600&fit=crop&fm=jpg&q=80', // Pineapple Festival Colors
    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&h=600&fit=crop&fm=jpg&q=80', // Pineapple Juice Delight
    'https://images.unsplash.com/photo-1600298881974-6be191ceeda1?w=800&h=600&fit=crop&fm=jpg&q=80', // Tropical Pineapple Cocktail
    'https://images.unsplash.com/photo-1618897096794-7bb628594e8b?w=800&h=600&fit=crop&fm=jpg&q=80', // Grilled Pineapple Perfection
    'https://images.unsplash.com/photo-1615485925600-97237c4fc1ec?w=800&h=600&fit=crop&fm=jpg&q=80', // Pineapple Crown Jewels
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
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Center(
        child: Container(
          width: 400,
          height: 300,
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
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  personalPhotos[currentImageIndex],
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Pineapple corners
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text('🍍', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text('🍍', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text('🍍', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text('🍍', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
                // Title
                Positioned(
                  bottom: 20,
                  left: 50,
                  right: 50,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '🍍 Beautiful Pineapple Photo ${currentImageIndex + 1}/14 - Fix AWS CORS for personal photos ✨',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}