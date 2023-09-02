import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mobx/mobx.dart';
import 'package:transition/transition.dart';

import 'package:wwatch/Screens/about/about_screen.dart';
import 'package:wwatch/Screens/settings/components/brightness_selector.dart';
import 'package:wwatch/Screens/settings/components/color_selector.dart';
import 'package:wwatch/Screens/settings/components/fab_position.dart';
import 'package:wwatch/Screens/settings/components/general_settings.dart';
import 'package:wwatch/Screens/settings/components/tile_mode_selector.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/main.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({
    Key? key,
    this.fab,
    required this.movieStore,
  }) : super(key: key);
  final bool? fab;
  @override
  _SettingsStateScreen createState() => _SettingsStateScreen();
  final MovieStore movieStore;
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
      floatingActionButtonLocation: styleStore.fabPosition == 0
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: widget.fab != null && widget.fab!
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              backgroundColor: styleStore.primaryColor,
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.textOnPrimaries[styleStore.colorIndex!],
                ),
              ),
            )
          : Container(),
      backgroundColor: styleStore.backgroundColor,
      body: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
        SliverAppBar(
            leading: Container(
              decoration: BoxDecoration(
                  color: settingsStore.brightness == CustomBrightness.amoled
                      ? styleStore.backgroundColor
                      : styleStore.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(16),
                  )),
              child: IconButton(
                color: settingsStore.brightness != CustomBrightness.amoled
                    ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                    : styleStore.primaryColor,
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            backgroundColor: settingsStore.brightness == CustomBrightness.amoled
                ? styleStore.backgroundColor
                : styleStore.primaryColor,
            expandedHeight: 256,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                bool _collapsed = constraints.biggest.height ==
                    MediaQuery.of(context).padding.top + kToolbarHeight;
                return FlexibleSpaceBar(
                  expandedTitleScale: 2,
                  background: Container(
                    color: styleStore.backgroundColor,
                  ),
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context)!.settings.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont('Mitr',
                        color: _collapsed
                            ? settingsStore.brightness !=
                                    CustomBrightness.amoled
                                ? AppColors
                                    .textOnPrimaries[styleStore.colorIndex!]
                                : styleStore.primaryColor
                            : styleStore.textColor,
                        fontWeight: FontWeight.w300,
                        height: 1),
                  ),
                );
              },
            )),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 32,
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
                        color: styleStore.textColor,
                      ),
                      const SizedBox(
                        height: 56,
                        width: 8,
                      ),
                      Text(
                        AppLocalizations.of(context)!.aboutTheApp,
                        style: GoogleFonts.getFont('Mitr',
                            color: styleStore.textColor,
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
                    AppLocalizations.of(context)!.fabPosition,
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
                    AppLocalizations.of(context)!.appMainColor,
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
                    AppLocalizations.of(context)!.appBrightness,
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
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.homeScreenTile,
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TileModeSelectorWidget(),
                const SizedBox(
                  height: 32,
                ),
                GeneralSettings(
                  movieStore: widget.movieStore,
                ),
                const SizedBox(
                  height: 72,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.textSettingsMissing,
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
                    AppLocalizations.of(context)!.textSettingsMissing2,
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
                      onPressed: () {
                        launchInBrowser('https://www.themoviedb.org/');
                      },
                      child: Text(
                        AppLocalizations.of(context)!
                            .youCanGoThereByClickingHere,
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
                Text(
                  AppLocalizations.of(context)!.notOfficialApp,
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w200),
                ),
                const SizedBox(
                  height: 64,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
