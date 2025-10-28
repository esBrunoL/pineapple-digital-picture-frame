import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Custom pineapple-themed border widget for the digital picture frame
/// 🍍 Creates a unique and visually appealing frame border as specified!
class PineappleBorder extends StatelessWidget {
  final Widget child;
  final double borderWidth;
  final bool showAnimation;

  const PineappleBorder({
    Key? key,
    required this.child,
    this.borderWidth = 20.0,
    this.showAnimation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(borderWidth),
      decoration: BoxDecoration(
        // Enhanced multi-layer gradient for rich tropical feel
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFD700), // Rich Gold
            Color(0xFFFFB347), // Peach Orange  
            Color(0xFFFFA500), // Pure Orange
            Color(0xFFFF8C42), // Coral Orange
            Color(0xFFFF6347), // Tomato Red
            Color(0xFFFFB347), // Peach Orange
            Color(0xFFFFD700), // Rich Gold
          ],
          stops: [0.0, 0.15, 0.3, 0.45, 0.6, 0.8, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // Deep outer shadow for depth
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 12),
            spreadRadius: 2,
          ),
          // Golden glow effect
          BoxShadow(
            color: Color(0xFFFFD700).withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 0),
            spreadRadius: 5,
          ),
          // Inner highlight
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF8B4513), // Rich Saddle Brown
            width: 4,
          ),
          // Inner frame gradient for premium look
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C1810), // Dark brown
              Color(0xFF3D2817), // Medium brown
              Color(0xFF2C1810), // Dark brown
            ],
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(3), // Space between frame and content
          child: Stack(
            children: [
              // Main content with enhanced clipping
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: child,
                ),
              ),
              
              // Enhanced pineapple corner decorations
              ...showAnimation ? _buildAnimatedCorners() : _buildStaticCorners(),
              
              // Tropical leaf accents
              ..._buildLeafAccents(),
              
              // Corner embellishments for premium look
              ..._buildCornerEmbellishments(),
            ],
          ),
        ),
      ),
    );
  }

  /// Build static pineapple corner decorations
  List<Widget> _buildStaticCorners() {
    return [
      // Top-left pineapple
      Positioned(
        top: -5,
        left: -5,
        child: _buildPineappleCorner(),
      ),
      // Top-right pineapple
      Positioned(
        top: -5,
        right: -5,
        child: Transform.rotate(
          angle: math.pi / 2,
          child: _buildPineappleCorner(),
        ),
      ),
      // Bottom-left pineapple
      Positioned(
        bottom: -5,
        left: -5,
        child: Transform.rotate(
          angle: -math.pi / 2,
          child: _buildPineappleCorner(),
        ),
      ),
      // Bottom-right pineapple
      Positioned(
        bottom: -5,
        right: -5,
        child: Transform.rotate(
          angle: math.pi,
          child: _buildPineappleCorner(),
        ),
      ),
    ];
  }

  /// Build animated pineapple corner decorations
  List<Widget> _buildAnimatedCorners() {
    return [
      // Top-left pineapple (rotating)
      Positioned(
        top: -5,
        left: -5,
        child: _AnimatedPineapple(
          duration: const Duration(seconds: 8),
          child: _buildPineappleCorner(),
        ),
      ),
      // Top-right pineapple (pulsing)
      Positioned(
        top: -5,
        right: -5,
        child: _PulsatingPineapple(
          child: Transform.rotate(
            angle: math.pi / 2,
            child: _buildPineappleCorner(),
          ),
        ),
      ),
      // Bottom-left pineapple (rotating reverse)
      Positioned(
        bottom: -5,
        left: -5,
        child: _AnimatedPineapple(
          duration: const Duration(seconds: 12),
          reverse: true,
          child: Transform.rotate(
            angle: -math.pi / 2,
            child: _buildPineappleCorner(),
          ),
        ),
      ),
      // Bottom-right pineapple (pulsing)
      Positioned(
        bottom: -5,
        right: -5,
        child: _PulsatingPineapple(
          child: Transform.rotate(
            angle: math.pi,
            child: _buildPineappleCorner(),
          ),
        ),
      ),
    ];
  }

  /// Build tropical leaf accent decorations
  List<Widget> _buildLeafAccents() {
    return [
      // Top center leaves
      Positioned(
        top: -3,
        left: 0,
        right: 0,
        child: Center(
          child: _buildLeafAccent(),
        ),
      ),
      // Bottom center leaves
      Positioned(
        bottom: -3,
        left: 0,
        right: 0,
        child: Center(
          child: Transform.rotate(
            angle: math.pi,
            child: _buildLeafAccent(),
          ),
        ),
      ),
      // Left center leaves
      Positioned(
        left: -3,
        top: 0,
        bottom: 0,
        child: Center(
          child: Transform.rotate(
            angle: -math.pi / 2,
            child: _buildLeafAccent(),
          ),
        ),
      ),
      // Right center leaves
      Positioned(
        right: -3,
        top: 0,
        bottom: 0,
        child: Center(
          child: Transform.rotate(
            angle: math.pi / 2,
            child: _buildLeafAccent(),
          ),
        ),
      ),
    ];
  }

  /// Build a single pineapple corner decoration with enhanced design
  Widget _buildPineappleCorner() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        // Enhanced gradient for pineapple corners
        gradient: const RadialGradient(
          colors: [
            Color(0xFFFFE55C), // Bright yellow center
            Color(0xFFFFD700), // Gold
            Color(0xFFDAA520), // Darker gold edge
          ],
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF8B4513), // Rich brown
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
          BoxShadow(
            color: Color(0xFFFFD700).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          '🍍',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  /// Build corner embellishments for premium frame look
  List<Widget> _buildCornerEmbellishments() {
    return [
      // Top-left corner accent
      Positioned(
        top: 5,
        left: 5,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: Color(0xFFFFD700).withOpacity(0.6),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.4),
                blurRadius: 3,
                offset: const Offset(-1, -1),
              ),
            ],
          ),
        ),
      ),
      // Top-right corner accent
      Positioned(
        top: 5,
        right: 5,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: Color(0xFFFFD700).withOpacity(0.6),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.4),
                blurRadius: 3,
                offset: const Offset(1, -1),
              ),
            ],
          ),
        ),
      ),
      // Bottom-left corner accent
      Positioned(
        bottom: 5,
        left: 5,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: Color(0xFFFFD700).withOpacity(0.6),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.4),
                blurRadius: 3,
                offset: const Offset(-1, 1),
              ),
            ],
          ),
        ),
      ),
      // Bottom-right corner accent
      Positioned(
        bottom: 5,
        right: 5,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: Color(0xFFFFD700).withOpacity(0.6),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.4),
                blurRadius: 3,
                offset: const Offset(1, 1),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  /// Build enhanced leaf accent decoration
  Widget _buildLeafAccent() {
    return Container(
      width: 40,
      height: 12,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF228B22), // Deep Forest Green
            Color(0xFF32CD32), // Bright Lime Green
            Color(0xFF90EE90), // Light Green highlight
            Color(0xFF32CD32), // Bright Lime Green
            Color(0xFF228B22), // Deep Forest Green
          ],
          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Color(0xFF32CD32).withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF3CB371), // Medium Sea Green
              Color(0xFF98FB98), // Pale Green
              Color(0xFF3CB371), // Medium Sea Green
            ],
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

/// Animated rotating pineapple widget
class _AnimatedPineapple extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool reverse;

  const _AnimatedPineapple({
    required this.child,
    this.duration = const Duration(seconds: 10),
    this.reverse = false,
  });

  @override
  State<_AnimatedPineapple> createState() => _AnimatedPineappleState();
}

class _AnimatedPineappleState extends State<_AnimatedPineapple>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: (widget.reverse ? -1 : 1) * _controller.value * 2 * math.pi,
          child: widget.child,
        );
      },
    );
  }
}

/// Pulsating pineapple widget
class _PulsatingPineapple extends StatefulWidget {
  final Widget child;

  const _PulsatingPineapple({required this.child});

  @override
  State<_PulsatingPineapple> createState() => _PulsatingPineappleState();
}

class _PulsatingPineappleState extends State<_PulsatingPineapple>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: widget.child,
        );
      },
    );
  }
}