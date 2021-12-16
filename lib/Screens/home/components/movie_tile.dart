import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Screens/movie/movie_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';

import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class MovieTile extends StatelessWidget {
  final SimpleMovie movie;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();

  MovieTile({
    Key? key,
    required this.movie,
  }) : super(key: key);
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(16),
      width: 500,
      height: 550,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieScreen(
                movieId: movie.id,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            movie.posterPath != null
                ? Container(
                    width: 500,
                    height: 550,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          filterQuality: FilterQuality.medium,
                          fit: BoxFit.cover,
                        )),
                  )
                : Center(
                    child: Container(
                      child: Text(
                        'No Image :(',
                        style: GoogleFonts.getFont('Mitr',
                            color: AppColors.text,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                  padding: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  height: 40,
                  width: 180,
                  decoration: BoxDecoration(
                    color: AppColors.shape,
                    borderRadius: BorderRadius.circular(32),
                    border:
                        Border.all(color: styleStore.primaryColor!, width: 2),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'User Rating ',
                      style: GoogleFonts.getFont('Mitr',
                          color: AppColors.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${(movie.voteAverage)}',
                          style: GoogleFonts.getFont('Kodchasan',
                              color: AppColors.text,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                          text: '/10',
                          style: GoogleFonts.getFont('Kodchasan',
                              color: AppColors.text,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.overline),
                        )
                      ],
                    ),
                  )),
            ),
            Positioned(
              bottom: 130,
              left: 16,
              child: Container(
                width: 320,
                child: Wrap(
                  children: [
                    Text(
                      movie.title,
                      style: GoogleFonts.getFont('Mitr',
                          color: AppColors.text,
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 16,
              child: Container(
                width: 340,
                height: 75,
                child: Wrap(
                  children: [
                    Text(
                      movie.overview,
                      style: GoogleFonts.getFont('Mitr',
                          color: AppColors.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 106,
              left: 16,
              child: Container(
                width: 340,
                child: Wrap(
                  children: [
                    Text(
                      formattedData,
                      style: GoogleFonts.getFont(
                        'Kodchasan',
                        color: AppColors.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
