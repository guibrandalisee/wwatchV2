import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/style_store.dart';

class CustomSpeedDialHomeScreen extends StatelessWidget {
  const CustomSpeedDialHomeScreen({
    Key? key,
    required this.scrollController,
    required this.focusNode,
  }) : super(key: key);
  final ScrollController scrollController;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    final StyleStore styleStore = GetIt.I<StyleStore>();
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
            // focusNode.requestFocus();
            FocusScope.of(context).unfocus();

            try {
              await scrollController.animateTo(0,
                  duration: Duration(seconds: 1), curve: Curves.ease);
            } catch (e) {
              print('noScroll');
            }

            FocusScope.of(context).requestFocus(focusNode);
          },
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Search',
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.textColor,
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
          onTap: () {},
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Movies',
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
          child: Icon(
            LineIcons.video,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          backgroundColor: styleStore.primaryColor,
        ),
        SpeedDialChild(
          onTap: () {},
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'TV Shows',
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
          child: Icon(
            LineIcons.television,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          backgroundColor: styleStore.primaryColor,
        ),
        SpeedDialChild(
          onTap: () {},
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Popular',
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
          child: Icon(
            LineIcons.lineChart,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          backgroundColor: styleStore.primaryColor,
        ),
        SpeedDialChild(
          onTap: () {},
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Upcoming',
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
          child: Icon(
            LineIcons.clock,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          backgroundColor: styleStore.primaryColor,
        ),
        SpeedDialChild(
          onTap: () {},
          labelWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'People',
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          ),
          child: Icon(
            LineIcons.users,
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          backgroundColor: styleStore.primaryColor,
        ),
      ],
    );
  }
}
