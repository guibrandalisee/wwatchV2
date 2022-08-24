import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'package:wwatch/Screens/filters_screen/filters_screen.dart';
import 'package:wwatch/Screens/settings/settings_screen.dart';
import 'package:wwatch/Screens/user/user_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';

class CustomSpeedDialHomeScreen extends StatelessWidget {
  CustomSpeedDialHomeScreen({
    Key? key,
    required this.movieStore,
    required this.scrollController,
    required this.focusNode,
  }) : super(key: key);
  final MovieStore movieStore;
  final ScrollController scrollController;
  final FocusNode focusNode;
  final StyleStore styleStore = GetIt.I<StyleStore>();

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      tooltip: 'Navigation Menu',
      switchLabelPosition: styleStore.fabPosition == 0 ? true : false,
      spaceBetweenChildren: 16,
      overlayColor: Colors.black.withOpacity(0.1),
      backgroundColor: styleStore.primaryColor,
      iconTheme: IconThemeData(
        color: AppColors.textOnPrimaries[styleStore.colorIndex!],
      ),
      icon: Icons.menu,
      activeIcon: Icons.close,
      children: [
        SpeedDialChild(
          onTap: () async {
            FocusScope.of(context).unfocus();

            try {
              await scrollController.animateTo(120,
                  duration: Duration(seconds: 1), curve: Curves.ease);
            } catch (e) {
              print('noScroll');
            }

            FocusScope.of(context).requestFocus(focusNode);
          },
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppLocalizations.of(context)!.search,
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
          child: Icon(
            LineIcons.search,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          backgroundColor: styleStore.primaryColor,
        ),
        SpeedDialChild(
          onTap: () {
            settingsStore.switchContentType();
            movieStore.getPopularContent();
          },
          labelWidget: Observer(builder: (
            context,
          ) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                settingsStore.selectedContentType == 1
                    ? AppLocalizations.of(context)!.movies
                    : AppLocalizations.of(context)!.tvShows,
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            );
          }),
          child: Observer(builder: (context) {
            return Icon(
              settingsStore.selectedContentType == 1
                  ? LineIcons.video
                  : LineIcons.television,
              color: AppColors.textOnPrimaries[styleStore.colorIndex!],
            );
          }),
          backgroundColor: styleStore.primaryColor,
        ),
        SpeedDialChild(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FiltersScreen(
                          movieStore: movieStore,
                          fab: true,
                        )));
          },
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppLocalizations.of(context)!.filters,
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
          child: Icon(
            LineIcons.filter,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          backgroundColor: styleStore.primaryColor,
        ),
        SpeedDialChild(
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SettingsScreen(
                      fab: true,
                      movieStore: movieStore,
                    )));
          },
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppLocalizations.of(context)!.settings,
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
          child: Icon(
            LineIcons.cog,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          backgroundColor: styleStore.primaryColor,
        ),
        SpeedDialChild(
          onTap: () async {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => UserScreen()));
          },
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Profile",
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
          child: Icon(
            LineIcons.user,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          backgroundColor: styleStore.primaryColor,
        ),
      ],
    );
  }
}
