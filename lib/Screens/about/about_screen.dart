import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Screens/welcome/welcome_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/main.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StyleStore styleStore = GetIt.I<StyleStore>();
    final SettingsStore settingsStore = GetIt.I<SettingsStore>();
    return Scaffold(
      backgroundColor: styleStore.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: settingsStore.brightness != CustomBrightness.amoled
              ? AppColors.textOnPrimaries[styleStore.colorIndex!]
              : styleStore.primaryColor,
        ),
        backgroundColor: settingsStore.brightness == CustomBrightness.amoled
            ? styleStore.backgroundColor
            : styleStore.primaryColor,
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(),
              ),
            );
          },
          child: Ink(
            child: Center(
              child: Image(
                image: ResizeImage(
                    AssetImage(
                      'assets/images/WWatch2-png.png',
                    ),
                    height: 156,
                    width: 156),
                filterQuality: FilterQuality.medium,
                color: settingsStore.brightness != CustomBrightness.amoled
                    ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                    : styleStore.primaryColor,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 120,
              ),
              Text(
                "ABOUT",
                style: GoogleFonts.getFont('Mitr',
                    color: styleStore.textColor,
                    fontSize: 48,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                "Information about the APP",
                style: GoogleFonts.getFont('Mitr',
                    color: styleStore.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w100),
              ),
              SizedBox(
                height: 120,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Made by:",
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    color: styleStore.shapeColor,
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 96,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/me.jpg"),
                      radius: 36,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Guilherme Brandalise",
                            style: GoogleFonts.getFont('Mitr',
                                color: styleStore.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 28,
                            width: 72,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      launchInBrowser(
                                          "https://github.com/guibrandalisee");
                                    },
                                    child: Ink(
                                      child: Image.asset(
                                          "assets/images/GitHubLogo.png"),
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 18,
                                    color: styleStore.textColor,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      launchInBrowser(
                                          "https://www.linkedin.com/in/guibrandalisee/");
                                    },
                                    child: Ink(
                                      child: Image.asset(
                                          "assets/images/LinkedInLogo.png"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Made by:",
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    color: styleStore.shapeColor,
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 96,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      height: 56,
                      width: 96,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "G22 Technologies",
                            style: GoogleFonts.getFont('Mitr',
                                color: styleStore.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 28,
                            width: 56,
                            child: Image.asset(
                              "assets/images/GooglePlayLogo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Buy me a coffee:",
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 56,
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: styleStore.shapeColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        launchInBrowser("https://www.google.com");
                      },
                      child: Ink(
                        child: SizedBox(
                          width: 120,
                          child: Image.asset(
                            "assets/images/PayPalLogo.png",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 3,
                      height: 36,
                      decoration: BoxDecoration(
                          color: styleStore.textColor,
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    InkWell(
                      onTap: () {
                        launchInBrowser("https://www.google.com");
                      },
                      child: Ink(
                        child: SizedBox(
                            width: 120,
                            child:
                                Image.asset("assets/images/PatreonLogo.png")),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Dont forget to review the app on the PlayStore",
                  style: GoogleFonts.getFont(
                    'Mitr',
                    color: styleStore.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 64,
                width: 125,
                child: Image.asset(
                  "assets/images/GooglePlayLogo.png",
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "This way we can keep improving it",
                  style: GoogleFonts.getFont(
                    'Mitr',
                    color: styleStore.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 56,
              ),
              Divider(
                color: styleStore.textColor,
                endIndent: 16,
                indent: 16,
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "App made using ",
                      style: GoogleFonts.getFont(
                        'Mitr',
                        color: styleStore.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: "The Movie DB API",
                          style: GoogleFonts.getFont(
                            'Mitr',
                            color: styleStore.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ]),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                height: 56,
                child: Image.asset("assets/images/MovieDB.png"),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(styleStore.primaryColor),
                  fixedSize: MaterialStateProperty.all(
                    Size.fromWidth(280),
                  ),
                ),
                onPressed: () {
                  launchInBrowser('https://www.themoviedb.org/');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "Go to their WebSite",
                    style: GoogleFonts.getFont(
                      'Mitr',
                      color: AppColors.textOnPrimaries[styleStore.colorIndex!],
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "DISCLAIMER",
                  style: GoogleFonts.getFont(
                    'Mitr',
                    color: styleStore.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "We don't have any sort of affiliation with TMDB, this is just an app made using their API, any content related issues must be reported on their website",
                  style: GoogleFonts.getFont(
                    'Mitr',
                    color: styleStore.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w100,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
