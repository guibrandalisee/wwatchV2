class AvaliableContentLanguages {
  String iso_639_1;
  String englishName;
  String name;
  AvaliableContentLanguages({
    required this.iso_639_1,
    required this.englishName,
    required this.name,
  });
}

class FilterDefaultValues {
  static final double voteCountMaxValue = 10000;
  static final double voteCountMinValue = 0;
  static final double voteAvgMaxValue = 10;
  static final double voteAvgMinValue = 0;
  static final double runTimeMaxValue = 180;
  static final double runTimeMinValue = 3;
}
