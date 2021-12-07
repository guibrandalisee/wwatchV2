import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:transition/transition.dart';
import 'package:wwatch/Screens/about/about_screen.dart';
import 'package:wwatch/Screens/settings/components/brightness_selector.dart';
import 'package:wwatch/Screens/settings/components/color_selector.dart';
import 'package:wwatch/Screens/settings/components/fab_position.dart';
import 'package:wwatch/Screens/settings/components/general_settings.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/settings_store.dart';
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
    reaction((_) => styleStore.backgroundColor, (value) {
      setState(() {});
    });
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
        title: Container(
          child: Hero(
            tag: "logo",
            child: SizedBox(
              height: 56,
              child: Image.asset(
                "assets/images/WWatch2-png.png",
                color: settingsStore.brightness != CustomBrightness.amoled
                    ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                    : styleStore.primaryColor,
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
              const SizedBox(
                width: double.infinity,
                height: 120,
              ),
              Text(
                "SETTINGS",
                style: GoogleFonts.getFont('Mitr',
                    color: styleStore.textColor,
                    fontSize: 48,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                "Configure your APP",
                style: GoogleFonts.getFont('Mitr',
                    color: styleStore.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w100),
              ),
              const SizedBox(
                height: 120,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(styleStore.dropdownColor)),
                onPressed: () {
                  Navigator.push(
                      context,
                      Transition(
                          child: const AboutScreen(),
                          transitionEffect: TransitionEffect.FADE));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LineIcons.infoCircle,
                      color: AppColors.text,
                    ),
                    const SizedBox(
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
              const SizedBox(
                height: 56,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Floating Action Button Position",
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const FabPosition(),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "App Main Color",
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const ColorSelector(),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "App Brightness",
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const BrightnessSelector(),
              const SizedBox(
                height: 32,
              ),
              const GeneralSettings(),
              const SizedBox(
                height: 72,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Think there are any account settings missing?",
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "You can probably find them on the official website",
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
              Observer(builder: (_) {
                return SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "You can go there by clicking here",
                      style: GoogleFonts.getFont(
                        'Mitr',
                        color:
                            AppColors.textOnPrimaries[styleStore.colorIndex!],
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
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Or give us feedback on our playstore page, we will be glad to implement it",
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
                height: 32,
              ),
              SizedBox(
                height: 56,
                child: Image.asset("assets/images/MovieDB.png"),
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
