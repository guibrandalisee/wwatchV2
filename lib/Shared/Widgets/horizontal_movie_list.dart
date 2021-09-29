import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';

enum MovieType { POPULAR, TRAILERS, TOPRATED, THEATERS }

class HorizontalMovieList extends StatelessWidget {
  MovieStore movieStore = GetIt.I<MovieStore>();
  MovieType movieType;
  final String title;
  List<Movie> movies = [];
  HorizontalMovieList({
    Key? key,
    required this.movieType,
    required this.title,
  }) : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();

  @override
  Widget build(BuildContext context) {
    if (movieType == MovieType.POPULAR) {
      movieStore.getPopularMovies();
      movies = movieStore.popularMovies;
    } else if (movieType == MovieType.TOPRATED) {
      movieStore.getTopRatedMovies();

      movies = movieStore.topRatedMovies;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.shape,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 320,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(LineIcons.alternateTicket, color: Colors.white),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      title,
                      style: GoogleFonts.getFont('Mitr',
                          color: AppColors.text,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                RotatedBox(
                    quarterTurns: 1,
                    child: Icon(LineIcons.locationArrow, color: Colors.white))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                    ),
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    width: 170,
                    child: Stack(
                      children: [
                        Image.network(
                          'https://image.tmdb.org/t/p/w500${movies[index].posterPath}',
                          filterQuality: FilterQuality.none,
                        ),
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color:
                                    styleStore.primaryColor!.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                    color: styleStore.primaryColor!)),
                            child: Text(
                              '${(movies[index].voteAverage * 10).toInt()}%',
                              style: GoogleFonts.getFont('Mitr',
                                  color: AppColors.text,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 8,
                          child: Container(
                            width: 170,
                            child: Wrap(
                              children: [
                                Text(
                                  movies[index].title,
                                  style: GoogleFonts.getFont('Mitr',
                                      color: AppColors.text,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
