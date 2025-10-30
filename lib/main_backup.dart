import 'package:flutter/material.dart';

void main() {
  runApp(const MinimalPineappleApp());
}

class MinimalPineappleApp extends StatelessWidget {
  const MinimalPineappleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pineapple Digital Picture Frame - Working!',
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
  
  // Set system UI overlay style for immersive experience
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF1A1A1A),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  print('🍍 Starting Pineapple Digital Picture Frame...');
  
  runApp(const PineappleFrameApp());
}

/// Main application widget for the Pineapple Digital Picture Frame
class PineappleFrameApp extends StatelessWidget {
  const PineappleFrameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App metadata
      title: 'Pineapple Digital Picture Frame',
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: ThemeData(
        // Primary colors inspired by pineapple theme
        primarySwatch: Colors.orange,
        primaryColor: const Color(0xFFFFD700), // Gold
        scaffoldBackgroundColor: const Color(0xFF1A1A1A), // Dark background
        
        // Color scheme
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFD700), // Gold
          secondary: Color(0xFFFFA500), // Orange  
          surface: Color(0xFF2C3E50), // Dark blue-gray
          background: Color(0xFF1A1A1A), // Very dark gray
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
        ),
        
        // Typography
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFFFFD700),
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(color: Colors.white70),
          bodyMedium: TextStyle(color: Colors.white60),
        ),
        
        // Button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFD700),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            shadowColor: Colors.black26,
          ),
        ),
        
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: Colors.white70,
          ),
        ),
        
        // Progress indicator theme
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFFFFD700),
          linearTrackColor: Colors.white24,
        ),
        
        // Use Material 3 design
        useMaterial3: true,
      ),
      
      // Home screen
      home: const FrameScreen(),
      
      // Route configuration (for future expansion)
      routes: {
        '/frame': (context) => const FrameScreen(),
      },
      
      // Error handling
      builder: (context, widget) {
        // Handle any rendering errors gracefully
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return _buildErrorWidget(errorDetails);
        };
        return widget!;
      },
    );
  }

  /// Build custom error widget for graceful error handling
  Widget _buildErrorWidget(FlutterErrorDetails errorDetails) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red.shade900.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.red),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '🍍',
                  style: TextStyle(fontSize: 48),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Oops! Picture Frame Error',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Something went wrong with the pineapple display.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Restart the app
                    SystemNavigator.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Restart Frame'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
