import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';

import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final CompleteMovie movie;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 1,
            child: Container(
                child: movie.backdropPath != null &&
                        movie.backdropPath!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.medium,
                      )
                    : movie.posterPath != null && movie.posterPath!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.medium,
                          )
                        : Center(
                            child: Container(
                            child: Text(
                              'No Image :(',
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                            ),
                          ))),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  styleStore.backgroundColor!,
                  Colors.transparent,
                  Colors.transparent,
                ],
                stops: const [
                  0.075,
                  0.6,
                  1,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 56,
            left: 8,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.shape,
                    borderRadius: BorderRadius.circular(32),
                    border:
                        Border.all(color: styleStore.primaryColor!, width: 2)),
                child: RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.userRating,
                    style: GoogleFonts.getFont('Mitr',
                        color: AppColors.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${(movie.voteAverage.toStringAsFixed(1))}',
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
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            height: 30,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: movie.genres.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: settingsStore.brightness ==
                                  CustomBrightness.amoled
                              ? AppColors.background
                              : Colors.black54),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Text(
                          movie.genres[index]['name'],
                          style: GoogleFonts.getFont('Mitr',
                              color: AppColors.text,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                      ));
                }),
          )
        ],
      ),
    );
  }
}
