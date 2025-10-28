import 'package:flutter/material.dart';
import '../services/image_rotation_service.dart';

/// Control panel for pause/resume and navigation functionality
/// 🍍 Beautifully themed controls for the pineapple picture frame!
class ControlPanel extends StatelessWidget {
  final ImageRotationService rotationService;
  final VoidCallback? onRefresh;

  const ControlPanel({
    Key? key,
    required this.rotationService,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        // Enhanced gradient with more tropical tones
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2C3E50), // Dark blue-gray
            Color(0xFF34495E), // Medium blue-gray
            Color(0xFF3D4F5F), // Lighter blue-gray
            Color(0xFF2C3E50), // Dark blue-gray
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Color(0xFFFFD700).withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          // Deep shadow for depth
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
          // Golden glow
          BoxShadow(
            color: Color(0xFFFFD700).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 0),
            spreadRadius: 5,
          ),
          // Inner highlight
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous button
          _buildControlButton(
            icon: Icons.skip_previous,
            onPressed: rotationService.previousImage,
            tooltip: 'Previous Image',
            color: Colors.white70,
          ),
          
          const SizedBox(width: 15),
          
          // Play/Pause button (main control)
          _buildMainControlButton(
            icon: rotationService.isPlaying ? Icons.pause : Icons.play_arrow,
            onPressed: rotationService.togglePlayPause,
            tooltip: rotationService.isPlaying ? 'Pause Rotation' : 'Resume Rotation',
            isPlaying: rotationService.isPlaying,
          ),
          
          const SizedBox(width: 15),
          
          // Next button
          _buildControlButton(
            icon: Icons.skip_next,
            onPressed: rotationService.nextImage,
            tooltip: 'Next Image',
            color: Colors.white70,
          ),
          
          const SizedBox(width: 20),
          
          // Progress indicator
          _buildProgressIndicator(),
          
          const SizedBox(width: 20),
          
          // Refresh button
          if (onRefresh != null) ...[
            _buildControlButton(
              icon: Icons.refresh,
              onPressed: onRefresh,
              tooltip: 'Refresh Images',
              color: Colors.orange[300],
            ),
          ],
          
          // Info button
          _buildControlButton(
            icon: Icons.info_outline,
            onPressed: () => _showImageInfo(context),
            tooltip: 'Image Information',
            color: Colors.blue[300],
          ),
        ],
      ),
    );
  }

  /// Build a standard control button
  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required String tooltip,
    Color? color,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(22.5),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: color ?? Colors.white70,
            size: 22,
          ),
          onPressed: onPressed,
          splashRadius: 20,
        ),
      ),
    );
  }

  /// Build the main play/pause control button (larger and more prominent)
  Widget _buildMainControlButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required String tooltip,
    required bool isPlaying,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isPlaying
                ? [
                    const Color(0xFFFF6B35), // Orange-red
                    const Color(0xFFFF8E53), // Lighter orange
                  ]
                : [
                    const Color(0xFF4CAF50), // Green
                    const Color(0xFF66BB6A), // Lighter green
                  ],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: (isPlaying ? Colors.orange : Colors.green).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          onPressed: onPressed,
          splashRadius: 25,
        ),
      ),
    );
  }

  /// Build progress indicator showing current image position
  Widget _buildProgressIndicator() {
    final current = rotationService.currentIndex + 1;
    final total = rotationService.totalImages;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.photo_library,
            color: Colors.white70,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            '$current/$total',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Show image information dialog
  void _showImageInfo(BuildContext context) {
    final currentImage = rotationService.currentImage;
    if (currentImage == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2C3E50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.info,
                color: Color(0xFFFFD700),
              ),
              const SizedBox(width: 10),
              const Text(
                'Image Details',
                style: TextStyle(color: Colors.white),
              ),
              const Spacer(),
              const Text(
                '🍍',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Title', currentImage.title),
              const SizedBox(height: 8),
              _buildInfoRow('Theme', currentImage.pineappleTheme.replaceAll('_', ' ').toUpperCase()),
              const SizedBox(height: 8),
              if (currentImage.description != null)
                _buildInfoRow('Description', currentImage.description!),
              const SizedBox(height: 8),
              _buildInfoRow('Added', _formatDate(currentImage.dateAdded)),
              const SizedBox(height: 8),
              _buildInfoRow('Position', '${rotationService.currentIndex + 1} of ${rotationService.totalImages}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Close',
                style: TextStyle(color: Color(0xFFFFD700)),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Build information row for dialog
  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  /// Format date for display
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}