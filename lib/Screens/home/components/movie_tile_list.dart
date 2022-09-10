import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wwatch/Screens/movie/movie_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class MovieTileList extends StatelessWidget {
  MovieTileList({
    Key? key,
    required this.prefs,
    required this.movie,
    required this.contentType,
  }) : super(key: key);
  final SharedPreferences prefs;

  final SimpleMovie movie;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final CustomContentType contentType;

  @override
  Widget build(BuildContext context) {
    String formattedData = '';
    if (movie.releaseDate != null && movie.releaseDate!.length == 10) {
      switch (settingsStore.dateFormat) {
        case 'dd/mm/yyyy':
          formattedData =
              '${movie.releaseDate!.substring(8, 10)}/${movie.releaseDate!.substring(5, 7)}/${movie.releaseDate!.substring(0, 4)}';
          break;
        case 'mm/dd/yyyy':
          formattedData =
              '${movie.releaseDate!.substring(5, 7)}/${movie.releaseDate!.substring(8, 10)}/${movie.releaseDate!.substring(0, 4)}';
          break;
        case 'yyyy/mm/dd':
          formattedData = movie.releaseDate!.replaceAll('-', '/');
          break;
        default:
      }
    }
    return Container(
      decoration: BoxDecoration(
          color: styleStore.shapeColor, borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: 148,
      width: double.infinity,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieScreen(
                prefs: prefs,
                movieId: movie.id,
                contentType: contentType,
              ),
            ),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: movie.posterPath != null
                  ? Container(
                      width: 86,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w154${movie.posterPath}',
                            filterQuality: FilterQuality.medium,
                            fit: BoxFit.cover,
                          )),
                    )
                  : Center(
                      child: Container(
                        width: 86,
                        child: Center(
                          child: Text(
                            'No Image :(',
                            style: GoogleFonts.getFont('Mitr',
                                color: styleStore.textColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 56,
                      child: Wrap(
                        children: [
                          Text(
                            movie.title,
                            style: GoogleFonts.getFont('Mitr',
                                color: styleStore.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: 24,
                            width: 56,
                            decoration: BoxDecoration(
                              color: AppColors.shape,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: styleStore.primaryColor!, width: 2),
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: movie.voteAverage % 1 == 0
                                    ? '${(movie.voteAverage.toStringAsFixed(0))}'
                                    : '${(movie.voteAverage.toStringAsFixed(1))}',
                                style: GoogleFonts.getFont('Kodchasan',
                                    color: AppColors.text,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '/10',
                                    style: GoogleFonts.getFont(
                                      'Kodchasan',
                                      color: AppColors.text,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w300,
                                      decoration: TextDecoration.overline,
                                    ),
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          child: Wrap(
                            children: [
                              Text(
                                formattedData,
                                style: GoogleFonts.getFont(
                                  'Kodchasan',
                                  color: styleStore.textColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w300,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 56,
                      child: Wrap(
                        children: [
                          Text(
                            movie.overview,
                            style: GoogleFonts.getFont('Mitr',
                                color: styleStore.textColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w300),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
