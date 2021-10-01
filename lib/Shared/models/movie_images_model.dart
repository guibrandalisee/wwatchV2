enum ImageType { BACKDROP, POSTER }

class MovieImage {
  final ImageType type;
  final String filePath;
  final String? language;
  MovieImage({
    required this.type,
    required this.filePath,
    this.language,
  });
}
