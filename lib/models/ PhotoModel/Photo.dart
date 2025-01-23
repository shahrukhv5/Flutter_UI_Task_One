class Photo {
  final String id;
  final String downloadUrl;
  final String url;

  Photo({
    required this.id,
    required this.downloadUrl,
    required this.url,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      downloadUrl: json['download_url'] as String,
      url: json['url'] ?? '',
    );
  }
}
