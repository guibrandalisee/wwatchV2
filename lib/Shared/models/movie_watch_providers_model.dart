enum PayingType { FLATRATE, RENT, BUY }

//TODO fix this
class MovieWatchProvider {
  final String? country;
  final String link;
  final String logoPath;
  final String name;
  final PayingType payingType;
  MovieWatchProvider({
    this.country,
    required this.link,
    required this.logoPath,
    required this.name,
    required this.payingType,
  });
}
