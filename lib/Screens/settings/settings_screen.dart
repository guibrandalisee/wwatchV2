import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:transition/transition.dart';
import 'package:wwatch/Screens/about/about_screen.dart';
import 'package:wwatch/Screens/settings/components/color_selector.dart';
import 'package:wwatch/Screens/settings/components/fab_position.dart';
import 'package:wwatch/Screens/settings/components/general_settings.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:mobx/mobx.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsStateScreen createState() => _SettingsStateScreen();
}

class _SettingsStateScreen extends State<SettingsScreen> {
  StyleStore styleStore = GetIt.I<StyleStore>();
  int index = 1;

  @override
  Widget build(BuildContext context) {
    reaction((_) => styleStore.primaryColor, (value) {
      setState(() {});
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.logo),
        backgroundColor: styleStore.primaryColor,
        title: Container(
          child: Hero(
            tag: "logo",
            child: SizedBox(
              height: 56,
              child: Image.asset(
                "assets/images/WWatch2-png.png",
                fit: BoxFit.fitHeight,
                filterQuality: FilterQuality.medium,
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
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 120,
              ),
              Text(
                "SETTINGS",
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 48,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                "Configure your APP",
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w100),
              ),
              SizedBox(
                height: 120,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.button)),
                onPressed: () {
                  Navigator.push(
                      context,
                      Transition(
                          child: AboutScreen(),
                          transitionEffect: TransitionEffect.FADE));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LineIcons.infoCircle),
                    SizedBox(
                      height: 56,
                      width: 8,
                    ),
                    Text(
                      "About the app",
                      style: GoogleFonts.getFont('Mitr',
                          color: AppColors.text,
                          fontSize: 18,
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 56,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Floating Action Button Position",
                  style: GoogleFonts.getFont('Mitr',
                      color: AppColors.text,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              FabPosition(),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "App Color",
                  style: GoogleFonts.getFont('Mitr',
                      color: AppColors.text,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ColorSelector(),
              SizedBox(
                height: 32,
              ),
              GeneralSettings(),
              SizedBox(
                height: 72,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Think there are any account settings missing?",
                  style: GoogleFonts.getFont('Mitr',
                      color: AppColors.text,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "You can probably find them on the official website",
                  style: GoogleFonts.getFont(
                    'Mitr',
                    color: AppColors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Observer(builder: (_) {
                return SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "You can go there by clicking here",
                      style: GoogleFonts.getFont(
                        'Mitr',
                        color: AppColors.text,
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(styleStore.primaryColor),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Or give us feedback on our playstore page, we will be glad to implement it",
                  style: GoogleFonts.getFont(
                    'Mitr',
                    color: AppColors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                height: 56,
                child: Image.asset("assets/images/MovieDB.png"),
              ),
              SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
