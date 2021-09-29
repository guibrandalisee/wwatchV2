import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';

import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/style_store.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  StyleStore styleStore = GetIt.I<StyleStore>();
  MovieTile({
    Key? key,
    required this.movie,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.all(16),
      width: 500,
      height: 550,
      child: Stack(
        children: [
          Container(
            width: 500,
            height: 550,
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              filterQuality: FilterQuality.none,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.6),
                Colors.transparent,
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
                padding: EdgeInsets.all(4),
                alignment: Alignment.center,
                height: 40,
                width: 180,
                decoration: BoxDecoration(
                    color: AppColors.shape,
                    borderRadius: BorderRadius.circular(32),
                    border:
                        Border.all(color: styleStore.primaryColor!, width: 2)),
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
                  /*Text(
                                      'User Rating ${(movieStore.popularMovies[index - 1].voteAverage * 10).toInt()}%',
                                      style: GoogleFonts.getFont('Mitr',
                                          color: AppColors.text,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),*/
                )),
          ),
          Positioned(
            bottom: 130,
            left: 16,
            child: Container(
              width: 340,
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
          //TODO formatar data
          Positioned(
            bottom: 106,
            left: 16,
            child: Container(
              width: 340,
              child: Wrap(
                children: [
                  Text(
                    movie.releaseDate,
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
    );
  }
}
