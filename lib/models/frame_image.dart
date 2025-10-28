/// Model class representing an image in our digital picture frame
class FrameImage {
  final String id;
  final String url;
  final String title;
  final String? description;
  final DateTime dateAdded;
  final String pineappleTheme; // Pineapple reference as requested!

  const FrameImage({
    required this.id,
    required this.url,
    required this.title,
    this.description,
    required this.dateAdded,
    required this.pineappleTheme,
  });

  /// Factory constructor for creating FrameImage from JSON
  factory FrameImage.fromJson(Map<String, dynamic> json) {
    return FrameImage(
      id: json['id'] as String,
      url: json['url'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      dateAdded: DateTime.parse(json['dateAdded'] as String),
      pineappleTheme: json['pineappleTheme'] as String,
    );
  }

  /// Convert FrameImage to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'description': description,
      'dateAdded': dateAdded.toIso8601String(),
      'pineappleTheme': pineappleTheme,
    };
  }

  @override
  String toString() {
    return 'FrameImage(id: $id, title: $title, pineappleTheme: $pineappleTheme)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FrameImage && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}