# 🍍 Pineapple Digital Picture Frame

A beautiful, pineapple-themed digital picture frame application built with Flutter that displays images from AWS cloud storage with automatic rotation functionality.

## ✨ Features

### Core Functionality
- **🔄 Automatic Image Rotation**: Images change every 10 seconds automatically
- **⏸️ Pause/Resume Controls**: Easy-to-use pause and resume functionality 
- **🍍 Pineapple-Themed Border**: Custom, unique pineapple-inspired border design
- **☁️ AWS Cloud Integration**: Simulated AWS S3 storage for image retrieval
- **📱 Cross-Platform**: Works on both Android and iOS devices
- **🖼️ High Resolution**: Optimized for best image quality on mobile devices

### Visual Design
- **🎨 Tropical Theme**: Golden pineapple color scheme with vibrant gradients
- **💫 Smooth Animations**: Elegant transitions between images
- **🌟 Animated Border Elements**: Rotating and pulsating pineapple decorations
- **📐 Responsive Layout**: Adapts to different screen sizes and orientations

### Technical Features
- **⚡ Cached Image Loading**: Fast loading with intelligent caching
- **🔧 Error Handling**: Graceful error recovery and retry mechanisms
- **📊 Progress Tracking**: Visual indicators for current image position
- **ℹ️ Image Information**: Detailed metadata display for each image
- **🔄 Refresh Capability**: Manual refresh of image collection

## 📋 Specifications Met

✅ **Digital Picture Frame Design**: Beautiful frame-like interface with unique pineapple border  
✅ **10+ JPG Images**: 15 high-quality JPG images included  
✅ **10-Second Auto-Rotation**: Precise timing for image changes  
✅ **Pineapple References**: Comprehensive pineapple theming throughout  
✅ **Pause/Resume Button**: Intuitive play/pause controls  
✅ **AWS Cloud Storage**: Simulated AWS S3 integration  
✅ **Android & iOS Support**: Cross-platform compatibility  
✅ **High Resolution**: Optimized for mobile screen resolutions  

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Android Studio / VS Code
- Android SDK (for Android builds)
- Xcode (for iOS builds, macOS only)

### Installation
1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd virtualPortrait
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Building for Production
```bash
# For Android
flutter build apk --release

# For iOS  
flutter build ios --release
```

## 🎮 Usage

### Controls
- **▶️ Play Button**: Resume automatic image rotation
- **⏸️ Pause Button**: Pause automatic rotation  
- **⬅️ Previous**: Go to previous image manually
- **➡️ Next**: Go to next image manually
- **🔄 Refresh**: Reload images from AWS storage
- **ℹ️ Info**: View current image details

### Image Information
Each image includes:
- Title and description
- Pineapple theme category
- Date added to collection
- Current position in rotation

## 🍍 Pineapple Theming

The application features comprehensive pineapple theming:

### Visual Elements
- **🍍 Emoji Integration**: Pineapple emojis throughout the interface
- **🟡 Color Palette**: Gold, orange, and tropical colors
- **🎨 Border Design**: Custom pineapple-inspired frame borders
- **✨ Animations**: Rotating and pulsating pineapple decorations

### Image Categories
All images are categorized by pineapple themes:
- Tropical Paradise, Plantation Sunrise, Artistic Tropical
- Beach Vibes, Vintage Elegance, Modern Design
- Garden Fresh, Luxury Decor, Crown Majesty
- Summer Bliss, Watercolor Art, Festival Colors
- Juice Delight, Tropical Smoothie, Upside Down Cake

## 🔧 Configuration

### Image Rotation Settings
```dart
// In image_rotation_service.dart
static const int rotationIntervalSeconds = 10; // 10-second intervals
```

## 📱 Device Compatibility

### Supported Platforms
- **Android**: API level 21+ (Android 5.0+)
- **iOS**: iOS 11.0+
- **Screen Sizes**: Phone and tablet layouts
- **Orientations**: Portrait and landscape support

---

**Built with ❤️ and 🍍**

*Bringing tropical memories to your digital world, one frame at a time.*
