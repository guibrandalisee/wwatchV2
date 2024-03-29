import 'package:flutter/material.dart';

class AppColors {
  //Dark
  static final background = Color(0xff252525);
  static Color primary = Color(0xffFF8500);
  static final shape = Color(0xff121212);
  static final text = Color(0xffE5E5E5);
  static final logo = Color(0xff332532);
  static final button = Color(0xff646464);
  static final divider = Color(0xff585858);
  static final dropdownButton = Color(0xff646464);

  //AMOLED
  static final backgroundAmoled = Colors.black;
  static final shapeAmoled = Color(0xff16161D);
  static final textAmoled = Color(0xffc4c4c4);
  static final dropdownAmoled = Color(0xff16161D);

  //Light
  static final backgroundLight = Color(0xffFFFFFF);
  static final shapeLight = Color(0xFFF3F3F3);
  // static final textLight = Color(0xff252525);
  static final textLight = Color.fromARGB(255, 45, 45, 65);
  // static final dropdownLight = Color(0xffe4e4e4);
  static final dropdownLight = Color.fromARGB(255, 239, 239, 239);

  static List<Color> primaries = [
    Color(0xffFF8500), //primaryOrange
    Color(0xff01D277), //primaryGreen
    Color(0xff8a05bf), //primaryPurple
    Color(0xff22AACE), //primaryBlue
    Color(0xffD40242), //primaryRed
    Color(0xffEA148C), // primaryPink
    Color(0xff0177D2), //primaryDarkBlue
    Color(0xFF522BBB), //primaryDarkPurple
  ];

  static List<Color> textOnPrimaries = [
    Color(0xff332532), //primaryOrange
    Color(0xff332532), //primaryGreen
    Color(0xffE5E5E5), //primaryPurple
    Color(0xff332532), //primaryBlue
    Color(0xffE5E5E5), //primaryRed
    Color(0xff332532), // primaryPink
    Color(0xff332532), //primaryDarkBlue
    Color(0xffE5E5E5), //primaryDarkPurple
  ];

  static List<String> imagesNoConnection = [
    'assets/noConnection/noConnection1.svg',
    'assets/noConnection/noConnection2.svg',
    'assets/noConnection/noConnection3.svg',
    'assets/noConnection/noConnection4.svg',
    'assets/noConnection/noConnection5.svg',
    'assets/noConnection/noConnection6.svg',
    'assets/noConnection/noConnection7.svg',
    'assets/noConnection/noConnection8.svg',
  ];

  static List<String> imagesNothingFound = [
    'assets/nothingFound/nothingFound1.svg',
    'assets/nothingFound/nothingFound2.svg',
    'assets/nothingFound/nothingFound3.svg',
    'assets/nothingFound/nothingFound4.svg',
    'assets/nothingFound/nothingFound5.svg',
    'assets/nothingFound/nothingFound6.svg',
    'assets/nothingFound/nothingFound7.svg',
    'assets/nothingFound/nothingFound8.svg',
  ];
}
