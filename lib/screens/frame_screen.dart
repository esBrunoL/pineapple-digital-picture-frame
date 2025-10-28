import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/image_rotation_service.dart';
import '../widgets/picture_frame.dart';

/// Main screen for the digital picture frame
/// 🍍 The complete pineapple digital picture frame experience!
class FrameScreen extends StatefulWidget {
  const FrameScreen({Key? key}) : super(key: key);

  @override
  State<FrameScreen> createState() => _FrameScreenState();
}

class _FrameScreenState extends State<FrameScreen>
    with WidgetsBindingObserver {
  late ImageRotationService _rotationService;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize the rotation service
    _rotationService = ImageRotationService();
    
    // Add lifecycle observer
    WidgetsBinding.instance.addObserver(this);
    
    // Initialize the service
    _initializeService();
    
    // Set preferred orientations for better frame experience
    _setPreferredOrientations();
  }

  @override
  void dispose() {
    // Clean up
    _rotationService.dispose();
    WidgetsBinding.instance.removeObserver(this);
    
    // Reset system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // Handle app lifecycle changes
    switch (state) {
      case AppLifecycleState.paused:
        // Pause rotation when app goes to background
        print('📱 App paused - stopping rotation');
        _rotationService.pause();
        break;
        
      case AppLifecycleState.resumed:
        // Resume rotation when app comes back to foreground
        print('📱 App resumed - starting rotation');
        if (_isInitialized) {
          _rotationService.resume();
        }
        break;
        
      case AppLifecycleState.inactive:
        // App is inactive (e.g., incoming call)
        _rotationService.pause();
        break;
        
      case AppLifecycleState.detached:
        // App is being destroyed
        _rotationService.dispose();
        break;
        
      case AppLifecycleState.hidden:
        // App is hidden (new lifecycle state)
        _rotationService.pause();
        break;
    }
  }

  /// Initialize the rotation service
  Future<void> _initializeService() async {
    try {
      print('🍍 Initializing Pineapple Digital Picture Frame...');
      
      await _rotationService.initialize();
      
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        print('✅ Picture frame initialized successfully!');
      }
      
    } catch (e) {
      print('❌ Failed to initialize picture frame: $e');
      
      if (mounted) {
        _showInitializationError(e.toString());
      }
    }
  }

  /// Set preferred orientations for optimal viewing
  Future<void> _setPreferredOrientations() async {
    // Allow both portrait and landscape for flexibility
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    // Set immersive mode for picture frame experience
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF1A1A1A),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Show initialization error dialog
  void _showInitializationError(String error) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2C3E50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text(
                'Initialization Error',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Failed to initialize the pineapple picture frame:',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 10),
              Text(
                error,
                style: const TextStyle(
                  color: Color(0xFFE57373), // Light red color
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Please check your internet connection and AWS configuration.',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _initializeService(); // Retry
              },
              child: const Text(
                'Retry',
                style: TextStyle(color: Color(0xFFFFD700)),
              ),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop(); // Close app
              },
              child: const Text(
                'Exit',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show loading screen while initializing
    if (!_isInitialized) {
      return _buildInitializationScreen();
    }

    // Main picture frame interface
    return PictureFrame(
      rotationService: _rotationService,
    );
  }

  /// Build initialization/loading screen
  Widget _buildInitializationScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated pineapple loading indicator
              TweenAnimationBuilder<double>(
                duration: const Duration(seconds: 2),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: 0.8 + (0.4 * value),
                    child: Transform.rotate(
                      angle: value * 2 * 3.14159,
                      child: const Text(
                        '🍍',
                        style: TextStyle(fontSize: 80),
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 30),
              
              // Loading text
              const Text(
                'Pineapple Digital Picture Frame',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFD700),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 10),
              
              const Text(
                'Loading tropical memories from AWS...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Progress indicator
              SizedBox(
                width: 200,
                child: const LinearProgressIndicator(
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFFFD700),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Fun facts about pineapples while loading
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                child: const Column(
                  children: [
                    Text(
                      '🍍 Fun Pineapple Facts 🍍',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFD700),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Pineapples are a symbol of hospitality and friendship!\n'
                      'They take about 18-20 months to grow to maturity.\n'
                      'Hawaii produces about 1/3 of the world\'s pineapples.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white60,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

