import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Screens/full_screen_image/full_screen_image.dart';

import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonHeaderWidget extends StatelessWidget {
  PersonHeaderWidget({
    Key? key,
    required this.movieStore,
  }) : super(key: key);
  final MovieStore movieStore;

  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();

  @override
  Widget build(BuildContext context) {
    String formattedBirthday = '';
    String formattedDetathDay = '';

    switch (settingsStore.dateFormat) {
      case 'dd/mm/yyyy':
        if (movieStore.person!.birthday != null &&
            movieStore.person!.birthday!.length == 10)
          formattedBirthday =
              '${movieStore.person!.birthday!.substring(8, 10)}/${movieStore.person!.birthday!.substring(5, 7)}/${movieStore.person!.birthday!.substring(0, 4)}';
        if (movieStore.person!.deathDay != null &&
            movieStore.person!.deathDay!.length == 10)
          formattedDetathDay =
              '${movieStore.person!.deathDay!.substring(8, 10)}/${movieStore.person!.deathDay!.substring(5, 7)}/${movieStore.person!.deathDay!.substring(0, 4)}';
        break;
      case 'mm/dd/yyyy':
        if (movieStore.person!.birthday != null &&
            movieStore.person!.birthday!.length == 10)
          formattedBirthday =
              '${movieStore.person!.birthday!.substring(5, 7)}/${movieStore.person!.birthday!.substring(8, 10)}/${movieStore.person!.birthday!.substring(0, 4)}';
        if (movieStore.person!.deathDay != null &&
            movieStore.person!.deathDay!.length == 10)
          formattedDetathDay =
              '${movieStore.person!.deathDay!.substring(5, 7)}/${movieStore.person!.deathDay!.substring(8, 10)}/${movieStore.person!.deathDay!.substring(0, 4)}';
        break;
      case 'yyyy/mm/dd':
        if (movieStore.person!.birthday != null &&
            movieStore.person!.birthday!.length == 10)
          formattedBirthday = movieStore.person!.birthday!.replaceAll('-', '/');
        if (movieStore.person!.deathDay != null &&
            movieStore.person!.deathDay!.length == 10)
          formattedDetathDay =
              movieStore.person!.deathDay!.replaceAll('-', '/');
        break;
      default:
    }
    return Container(
      height: 280,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          movieStore.person!.profilePath != null
              ? InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                            path:
                                "https://image.tmdb.org/t/p/original${movieStore.person!.profilePath}")));
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w342${movieStore.person!.profilePath}',
                          filterQuality: FilterQuality.medium,
                          fit: BoxFit.cover,
                          memCacheHeight: 248,
                          memCacheWidth: 165,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  width: 165,
                  alignment: Alignment.center,
                  child: Text(
                    'No Image :(',
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
          SizedBox(
            width: 16,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.name,
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
                Wrap(
                  children: [
                    Text(
                      movieStore.person!.name.trim(),
                      style: GoogleFonts.getFont(
                        'Mitr',
                        color: styleStore.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                if (formattedBirthday != '')
                  SizedBox(
                    height: 8,
                  ),
                if (formattedBirthday != '')
                  Text(
                    AppLocalizations.of(context)!.birthday,
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                if (formattedBirthday != '')
                  Wrap(
                    children: [
                      Text(
                        formattedBirthday,
                        style: GoogleFonts.getFont(
                          'Mitr',
                          color: styleStore.textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w100,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                if (formattedDetathDay != '')
                  SizedBox(
                    height: 8,
                  ),
                if (formattedDetathDay != '')
                  Text(
                    AppLocalizations.of(context)!.dayOfDeath,
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                if (formattedDetathDay != '')
                  Wrap(
                    children: [
                      Text(
                        formattedDetathDay,
                        style: GoogleFonts.getFont(
                          'Mitr',
                          color: styleStore.textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w100,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                if (movieStore.person!.placeOfBirth != null)
                  SizedBox(
                    height: 8,
                  ),
                if (movieStore.person!.placeOfBirth != null)
                  Text(
                    AppLocalizations.of(context)!.placeOfBirth,
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                if (movieStore.person!.placeOfBirth != null)
                  Wrap(
                    children: [
                      Text(
                        movieStore.person!.placeOfBirth!.trim(),
                        style: GoogleFonts.getFont(
                          'Mitr',
                          color: styleStore.textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w100,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
