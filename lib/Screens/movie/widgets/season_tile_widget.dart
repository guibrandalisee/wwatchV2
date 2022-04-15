import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wwatch/Screens/season/season_screen.dart';
import 'package:wwatch/Shared/models/tv_season_model.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class SeasonTileWidget extends StatelessWidget {
  SeasonTileWidget({
    Key? key,
    required this.season,
    required this.tvId,
    required this.prefs,
  }) : super(key: key);
  final TvSeason season;
  final int tvId;
  final SharedPreferences prefs;

  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final StyleStore styleStore = GetIt.I<StyleStore>();
  String formatDate(TvSeason season) {
    switch (settingsStore.dateFormat) {
      case 'dd/mm/yyyy':
        return '${season.airDate!.substring(8, 10)}/${season.airDate!.substring(5, 7)}/${season.airDate!.substring(0, 4)}';

      case 'mm/dd/yyyy':
        return '${season.airDate!.substring(5, 7)}/${season.airDate!.substring(8, 10)}/${season.airDate!.substring(0, 4)}';

      case 'yyyy/mm/dd':
        return season.airDate!.replaceAll('-', '/');
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SeasonScreen(
                  prefs: prefs,
                  tvId: tvId,
                  seasonNumber: season.seasonNumber,
                )));
      },
      child: Container(
        height: 130,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: styleStore.backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            season.posterPath != null && season.posterPath != ''
                ? Container(
                    width: 100,
                    height: 130,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w154${season.posterPath}',
                      filterQuality: FilterQuality.medium,
                      fit: BoxFit.fill,
                    ),
                  )
                : Container(
                    width: 100,
                    height: 130,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    color: Colors.black.withAlpha(80),
                    child: Center(
                      child: Text(
                        'No Image :(',
                        style: GoogleFonts.getFont('Mitr',
                            color: styleStore.textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                  ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 168,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        season.name,
                        style: GoogleFonts.getFont('Mitr',
                            color: styleStore.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w200),
                      ),
                      if (season.airDate != null) Expanded(child: SizedBox()),
                      if (season.airDate != null && season.name != 'Specials')
                        Container(
                          padding: EdgeInsets.only(
                            top: 4,
                          ),
                          child: Text(
                            formatDate(season).trim(),
                            textAlign: TextAlign.end,
                            style: GoogleFonts.getFont(
                              'Mitr',
                              color: styleStore.textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  '${season.episodeCount} ${AppLocalizations.of(context)!.episodes}',
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w100),
                ),
                SizedBox(
                  height: 8,
                ),
                if (season.overview != '')
                  Container(
                    width: MediaQuery.of(context).size.width - 160,
                    height: 75,
                    child: Wrap(
                      children: [
                        Text(
                          season.overview,
                          style: GoogleFonts.getFont('Mitr',
                              color: styleStore.textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
