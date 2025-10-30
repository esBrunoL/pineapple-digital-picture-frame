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

class MinimalFrameScreen extends StatelessWidget {
  const MinimalFrameScreen({Key? key}) : super(key: key);

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
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=800&h=600&fit=crop&fm=jpg&q=80',
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
                    child: const Text(
                      '🍍 Pineapple Picture Frame - Working! ✅',
                      style: TextStyle(
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