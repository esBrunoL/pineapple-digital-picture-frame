import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/frame_image.dart';
import 'aws_image_service.dart';

/// Service class managing automatic image rotation for the digital picture frame
/// 🍍 Rotates through pineapple-themed images every 10 seconds as specified!
class ImageRotationService extends ChangeNotifier {
  final AwsImageService _awsService = AwsImageService();
  
  // Configuration
  static const int rotationIntervalSeconds = 10;
  
  // State variables
  List<FrameImage> _images = [];
  int _currentIndex = 0;
  bool _isPlaying = true;
  bool _isLoading = true;
  String? _error;
  Timer? _rotationTimer;

  // Getters
  List<FrameImage> get images => _images;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  FrameImage? get currentImage {
    if (_images.isEmpty) return null;
    return _images[_currentIndex];
  }
  
  int get totalImages => _images.length;
  
  /// Initialize the rotation service
  Future<void> initialize() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      print('🍍 Initializing Pineapple Digital Picture Frame...');
      
      // Load images from AWS with timeout
      _images = await _awsService.getFrameImages(count: 14).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print('⏰ AWS S3 timeout - using fallback images');
          return _awsService.fetchAllImages(); // Fallback to sample images
        },
      );
      
      if (_images.isEmpty) {
        throw Exception('No images found in AWS S3');
      }
      
      _currentIndex = 0;
      _isLoading = false;
      
      print('🎯 Loaded ${_images.length} pineapple images');
      print('📸 Starting with: ${currentImage?.title}');
      
      // Start automatic rotation if playing
      if (_isPlaying) {
        _startRotationTimer();
      }
      
      notifyListeners();
      
    } catch (e) {
      _error = 'Failed to load images: $e';
      _isLoading = false;
      print('❌ Initialization error: $_error');
      notifyListeners();
    }
  }

  /// Start automatic rotation timer
  void _startRotationTimer() {
    _stopRotationTimer(); // Clear any existing timer
    
    _rotationTimer = Timer.periodic(
      const Duration(seconds: rotationIntervalSeconds),
      (timer) {
        if (_isPlaying && _images.isNotEmpty) {
          nextImage();
        }
      },
    );
    
    print('⏰ Auto-rotation started (${rotationIntervalSeconds}s intervals)');
  }

  /// Stop the rotation timer
  void _stopRotationTimer() {
    _rotationTimer?.cancel();
    _rotationTimer = null;
  }

  /// Move to the next image
  void nextImage() {
    if (_images.isEmpty) return;
    
    _currentIndex = (_currentIndex + 1) % _images.length;
    print('➡️ Next image: ${currentImage?.title} (${_currentIndex + 1}/${_images.length})');
    notifyListeners();
  }

  /// Move to the previous image  
  void previousImage() {
    if (_images.isEmpty) return;
    
    _currentIndex = (_currentIndex - 1 + _images.length) % _images.length;
    print('⬅️ Previous image: ${currentImage?.title} (${_currentIndex + 1}/${_images.length})');
    notifyListeners();
  }

  /// Jump to a specific image index
  void goToImage(int index) {
    if (_images.isEmpty || index < 0 || index >= _images.length) return;
    
    _currentIndex = index;
    print('🎯 Jumped to image: ${currentImage?.title} (${index + 1}/${_images.length})');
    notifyListeners();
  }

  /// Pause the automatic rotation
  void pause() {
    if (!_isPlaying) return;
    
    _isPlaying = false;
    _stopRotationTimer();
    print('⏸️ Picture frame paused');
    notifyListeners();
  }

  /// Resume the automatic rotation
  void resume() {
    if (_isPlaying) return;
    
    _isPlaying = true;
    _startRotationTimer();
    print('▶️ Picture frame resumed');
    notifyListeners();
  }

  /// Toggle pause/resume
  void togglePlayPause() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  /// Refresh images from AWS
  Future<void> refreshImages() async {
    print('🔄 Refreshing pineapple images from AWS...');
    await initialize();
  }

  /// Get progress information
  double get progress {
    if (_images.isEmpty) return 0.0;
    return (_currentIndex + 1) / _images.length;
  }

  /// Get remaining time for current image (approximation)
  String get timeRemaining {
    if (!_isPlaying) return 'Paused';
    return '${rotationIntervalSeconds}s';
  }

  /// Clean up resources
  @override
  void dispose() {
    _stopRotationTimer();
    print('🧹 Image rotation service disposed');
    super.dispose();
  }
}