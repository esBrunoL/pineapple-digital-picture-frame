import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/frame_image.dart';
import '../services/image_rotation_service.dart';
import 'pineapple_border.dart';
import 'control_panel.dart';

/// Main picture frame widget that displays images with pineapple-themed border
/// 🍍 The heart of our digital picture frame experience!
class PictureFrame extends StatefulWidget {
  final ImageRotationService rotationService;

  const PictureFrame({
    Key? key,
    required this.rotationService,
  }) : super(key: key);

  @override
  State<PictureFrame> createState() => _PictureFrameState();
}

class _PictureFrameState extends State<PictureFrame>
    with TickerProviderStateMixin {
  late AnimationController _imageTransitionController;
  late AnimationController _loadingController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers
    _imageTransitionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _loadingController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Setup animations
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _imageTransitionController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _imageTransitionController,
      curve: Curves.easeOutBack,
    ));

    // Start loading animation
    _loadingController.repeat();

    // Listen to rotation service changes
    widget.rotationService.addListener(_onImageChanged);
    
    // Start initial animation
    _imageTransitionController.forward();
  }

  @override
  void dispose() {
    _imageTransitionController.dispose();
    _loadingController.dispose();
    widget.rotationService.removeListener(_onImageChanged);
    super.dispose();
  }

  void _onImageChanged() {
    if (mounted) {
      // Trigger transition animation when image changes
      _imageTransitionController.reset();
      _imageTransitionController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // Dark background
      body: SafeArea(
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 600),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                // Header with title
                _buildHeader(),
                
                // Main picture frame area
                Expanded(
                  child: _buildMainFrame(),
                ),
                
                // Control panel
                _buildControlArea(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build the enhanced header section
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A1A1A),
            Color(0xFF1A1A1A).withOpacity(0.8),
          ],
        ),
      ),
      child: Row(
        children: [
          // Enhanced pineapple icon with glow
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFFD700).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: const Text(
              '🍍',
              style: TextStyle(fontSize: 40),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enhanced title with gradient text effect
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFFFFD700),
                      Color(0xFFFFA500),
                      Color(0xFFFFD700),
                    ],
                  ).createShader(bounds),
                  child: const Text(
                    'Pineapple Digital Frame',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFD700),
                        Color(0xFFFFA500),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '🌺 Tropical memories in motion 🌺',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _buildStatusIndicator(),
        ],
      ),
    );
  }

  /// Build the enhanced main frame area with premium styling
  Widget _buildMainFrame() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Subtle outer glow for the frame area
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFFD700).withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 0),
            spreadRadius: 10,
          ),
        ],
      ),
      child: ListenableBuilder(
        listenable: widget.rotationService,
        builder: (context, child) {
          if (widget.rotationService.isLoading) {
            return _buildLoadingFrame();
          }
          
          if (widget.rotationService.error != null) {
            return _buildErrorFrame(widget.rotationService.error!);
          }
          
          if (widget.rotationService.currentImage == null) {
            return _buildEmptyFrame();
          }
          
          return _buildImageFrame(widget.rotationService.currentImage!);
        },
      ),
    );
  }

  /// Build loading frame
  Widget _buildLoadingFrame() {
    return PineappleBorder(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _loadingController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _loadingController.value * 2 * 3.14159,
                    child: const Text(
                      '🍍',
                      style: TextStyle(fontSize: 64),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Loading tropical memories...',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build error frame
  Widget _buildErrorFrame(String error) {
    return PineappleBorder(
      showAnimation: false,
      child: Container(
        color: Colors.red[900],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 64,
              ),
              const SizedBox(height: 20),
              const Text(
                'Oops! Picture frame error',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => widget.rotationService.refreshImages(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build empty frame
  Widget _buildEmptyFrame() {
    return PineappleBorder(
      showAnimation: false,
      child: Container(
        color: Colors.grey[800],
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🍍',
                style: TextStyle(fontSize: 64),
              ),
              SizedBox(height: 20),
              Text(
                'No pineapple images found',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build image frame with the current image
  Widget _buildImageFrame(FrameImage image) {
    return AnimatedBuilder(
      animation: _imageTransitionController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: PineappleBorder(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Main image
                  CachedNetworkImage(
                    imageUrl: image.url,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.black,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFFFFD700),
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.black54,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image,
                              color: Colors.white54,
                              size: 64,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Failed to load image',
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Image overlay with title
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildImageOverlay(image),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build image overlay with title and theme info
  Widget _buildImageOverlay(FrameImage image) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withOpacity(0.8),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            image.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(1, 1),
                  blurRadius: 3,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '🍍 ${image.pineappleTheme.replaceAll('_', ' ').toUpperCase()}',
            style: const TextStyle(
              color: Color(0xFFFFD700),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Build status indicator
  Widget _buildStatusIndicator() {
    return ListenableBuilder(
      listenable: widget.rotationService,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: widget.rotationService.isPlaying 
                ? Colors.green.withOpacity(0.2)
                : Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: widget.rotationService.isPlaying ? Colors.green : Colors.orange,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.rotationService.isPlaying ? Icons.play_circle : Icons.pause_circle,
                color: widget.rotationService.isPlaying ? Colors.green : Colors.orange,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                widget.rotationService.isPlaying ? 'LIVE' : 'PAUSED',
                style: TextStyle(
                  color: widget.rotationService.isPlaying ? Colors.green : Colors.orange,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Build control area
  Widget _buildControlArea() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListenableBuilder(
        listenable: widget.rotationService,
        builder: (context, child) {
          return ControlPanel(
            rotationService: widget.rotationService,
            onRefresh: () => widget.rotationService.refreshImages(),
          );
        },
      ),
    );
  }
}

