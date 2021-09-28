import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/style_store.dart';

class CustomFAB extends StatelessWidget {
  final bool people;
  final bool upcoming;
  final bool genres;
  final bool popular;
  final bool tvshows;
  final bool movies;
  final bool home;
  final bool search;
  const CustomFAB({
    Key? key,
    this.people = false,
    this.upcoming = false,
    this.genres = false,
    this.popular = false,
    this.tvshows = false,
    this.movies = false,
    this.home = false,
    this.search = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StyleStore styleStore = GetIt.I<StyleStore>();
    return SpeedDial(
      switchLabelPosition: styleStore.fabPosition == 0 ? true : false,
      spaceBetweenChildren: 16,
      overlayColor: Colors.black.withOpacity(0.1),
      backgroundColor: styleStore.primaryColor,
      icon: Icons.menu,
      activeIcon: Icons.close,
      children: [
        if (search)
          SpeedDialChild(
            onTap: () {},
            labelWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Search',
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            child: Icon(
              LineIcons.search,
              color: Colors.white,
            ),
            backgroundColor: styleStore.primaryColor,
          ),
        if (home)
          SpeedDialChild(
            onTap: () {},
            labelWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Home',
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            child: Icon(
              LineIcons.home,
              color: Colors.white,
            ),
            backgroundColor: styleStore.primaryColor,
          ),
        if (movies)
          SpeedDialChild(
            onTap: () {},
            labelWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Movies',
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            child: Icon(
              LineIcons.video,
              color: Colors.white,
            ),
            backgroundColor: styleStore.primaryColor,
          ),
        if (tvshows)
          SpeedDialChild(
            onTap: () {},
            labelWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'TV Shows',
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            child: Icon(
              LineIcons.television,
              color: Colors.white,
            ),
            backgroundColor: styleStore.primaryColor,
          ),
        if (popular)
          SpeedDialChild(
            onTap: () {},
            labelWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Popular',
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            child: Icon(
              LineIcons.lineChart,
              color: Colors.white,
            ),
            backgroundColor: styleStore.primaryColor,
          ),
        if (genres)
          SpeedDialChild(
            onTap: () {},
            labelWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Genres',
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            child: Icon(
              LineIcons.film,
              color: Colors.white,
            ),
            backgroundColor: styleStore.primaryColor,
          ),
        if (upcoming)
          SpeedDialChild(
            onTap: () {},
            labelWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Upcoming',
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            child: Icon(
              LineIcons.clock,
              color: Colors.white,
            ),
            backgroundColor: styleStore.primaryColor,
          ),
        if (people)
          SpeedDialChild(
            onTap: () {},
            labelWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'People',
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
            child: Icon(
              LineIcons.users,
              color: Colors.white,
            ),
            backgroundColor: styleStore.primaryColor,
          ),
      ],
    );
  }
}
