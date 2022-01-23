import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobx/mobx.dart';
import 'package:wwatch/Screens/movie/widgets/season_tile_widget.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';

class SeasonEpisodeWidget extends StatelessWidget {
  SeasonEpisodeWidget({
    Key? key,
    required this.movieStore,
  }) : super(key: key);
  final MovieStore movieStore;
  final styleStore = GetIt.I<StyleStore>();
  final seasons = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 45,
        ),
        Divider(
          color: AppColors.divider,
          thickness: 1,
          endIndent: 24,
          indent: 24,
        ),
        const SizedBox(
          height: 16,
        ),
        Observer(builder: (context) {
          return Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            clipBehavior: Clip.antiAlias,
            child: ExpansionTile(
              onExpansionChanged: (a) {},
              collapsedIconColor: AppColors.text,
              collapsedTextColor: AppColors.text,
              collapsedBackgroundColor: styleStore.shapeColor,
              backgroundColor: styleStore.shapeColor,
              iconColor: styleStore.primaryColor,
              textColor: AppColors.text,
              title: Text(
                'All Seasons',
                style: GoogleFonts.getFont('Mitr',
                    color: AppColors.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
              children: movieStore.movie!.seasons!.map((e) {
                //TODO finish this widget
                return SeasonTileWidget(
                  season: e,
                );
              }).toList(),
            ),
          );
        }),
      ],
    );
  }
}
