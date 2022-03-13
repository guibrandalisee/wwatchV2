import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/style_store.dart';

class CustomSpeedDialMovieScreen extends StatelessWidget {
  CustomSpeedDialMovieScreen({Key? key}) : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      switchLabelPosition: styleStore.fabPosition == 0 ? true : false,
      elevation: 8,
      direction: SpeedDialDirection.up,
      overlayColor: Colors.black,
      backgroundColor: styleStore.primaryColor,
      iconTheme: IconThemeData(
        color: AppColors.textOnPrimaries[styleStore.colorIndex!],
      ),
      icon: Icons.add,
      activeIcon: Icons.close,
      spaceBetweenChildren: 16,
      children: [
        SpeedDialChild(
          backgroundColor: styleStore.primaryColor,
          child: Icon(
            LineIcons.list,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Add to a list',
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        SpeedDialChild(
          backgroundColor: styleStore.primaryColor,
          child: Icon(
            LineIcons.bookmark,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Add to your watchlist',
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        SpeedDialChild(
          backgroundColor: styleStore.primaryColor,
          child: Icon(
            LineIcons.star,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Rate it!',
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        SpeedDialChild(
          backgroundColor: styleStore.primaryColor,
          child: Icon(
            LineIcons.heart,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Mark as favorite',
              style: GoogleFonts.getFont('Mitr',
                  color: AppColors.text,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ],
    );
  }
}
