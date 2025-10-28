import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/frame_screen.dart';

/// 🍍 Pineapple Digital Picture Frame
/// A beautiful AWS-powered digital picture frame with automatic rotation,
/// custom pineapple-themed borders, and seamless pause/resume functionality.
/// 
/// Features:
/// - Auto-rotates images every 10 seconds
/// - Beautiful pineapple-themed custom border
/// - Pause/Resume functionality
/// - High-resolution image display
/// - AWS S3 integration (simulated)
/// - Responsive design for Android & iOS
void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
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
