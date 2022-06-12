class AvaliableWatchProviderRegions {
  String iso_3166_1;
  String englishName;
  String nativeName;
  AvaliableWatchProviderRegions({
    required this.iso_3166_1,
    required this.englishName,
    required this.nativeName,
  });
}

class AvaliableWatchProvider {
  int displayPriority;
  String logoPath;
  String providerName;
  int providerId;
  AvaliableWatchProvider({
    required this.displayPriority,
    required this.logoPath,
    required this.providerName,
    required this.providerId,
  });
}

class MovieAvaliableWatchProviders {
  String countryIso_3166_1;
  String link;
  List<AvaliableWatchProvider>? rent;
  List<AvaliableWatchProvider>? buy;
  List<AvaliableWatchProvider>? flatrate;
  List<AvaliableWatchProvider>? ads;
  List<AvaliableWatchProvider>? free;
  MovieAvaliableWatchProviders({
    required this.countryIso_3166_1,
    required this.link,
    this.rent,
    this.buy,
    this.flatrate,
    this.ads,
    this.free,
  });
}

class Country {
  String name;
  String iso_3166_1;
  Country({
    required this.name,
    required this.iso_3166_1,
  });
}

class AllCountriesWatchProviders {
  List<Country> flatrate;
  List<Country> rent;
  List<Country> buy;
  List<Country> free;
  List<Country> ads;
  AllCountriesWatchProviders({
    required this.flatrate,
    required this.rent,
    required this.buy,
    required this.free,
    required this.ads,
  });
}
