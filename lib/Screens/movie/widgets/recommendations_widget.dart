
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wwatch/Screens/movie/movie_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class RecommendationsWidget extends StatelessWidget {
  RecommendationsWidget({
    Key? key,
    required this.movieStore,
    required this.prefs,
  }) : super(key: key);
  final MovieStore movieStore;
  final SharedPreferences prefs;
  final ScrollController scrollController = ScrollController();
  final StyleStore styleStore = GetIt.I<StyleStore>();
  bool scrollInProgress = false;
  @override
  Widget build(BuildContext context) {
    if (movieStore.recommendations.length > 0) {
      return Column(
        children: [
          const SizedBox(
            height: 16,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (movieStore.recommendations.length > 1)
                IconButton(
                    splashRadius: 16,
                    onPressed: () async {
                      if (!scrollInProgress) {
                        scrollInProgress = true;
                        await scrollController.animateTo(
                            scrollController.offset - 200,
                            duration: Duration(milliseconds: 100),
                            curve: Curves.ease);
                        scrollInProgress = false;
                      }
                    },
                    icon: Icon(
                      Icons.chevron_left_rounded,
                      color: styleStore.textColor,
                      size: 22,
                    )),
              const SizedBox(
                width: 8,
              ),
              Text(
                AppLocalizations.of(context)!.recommendations,
                style: GoogleFonts.getFont('Mitr',
                    color: styleStore.textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                width: 8,
              ),
              if (movieStore.recommendations.length > 1)
                IconButton(
                    splashRadius: 16,
                    onPressed: () async {
                      if (!scrollInProgress) {
                        scrollInProgress = true;
                        await scrollController.animateTo(
                            scrollController.offset + 200,
                            duration: Duration(milliseconds: 100),
                            curve: Curves.ease);
                        scrollInProgress = false;
                      }
                    },
                    icon: Icon(
                      Icons.chevron_right_rounded,
                      color: styleStore.textColor,
                      size: 22,
                    )),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: movieStore.recommendations.length,
              itemBuilder: (
                context,
                index,
              ) {
                return SizedBox(
                    width: 200,
                    child: SimilarMovieTile(
                      prefs: prefs,
                      movie: movieStore.recommendations[index],
                    ));
              },
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}

class SimilarMovieTile extends StatelessWidget {
  final SimpleMovie movie;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final SharedPreferences prefs;

  SimilarMovieTile({
    Key? key,
    required this.movie,
    required this.prefs,
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
      margin: const EdgeInsets.all(8),
      width: 500,
      height: 550,
      child: GestureDetector(
        onTap: Feedback.wrapForTap(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieScreen(
                prefs: prefs,
                movieId: movie.id,
                contentType: settingsStore.selectedContentType,
              ),
            ),
          );
        }, context),
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
                              'https://image.tmdb.org/t/p/w342${movie.posterPath}',
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
                            fontSize: 18,
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
              bottom: 45,
              left: 8,
              child: Container(
                width: 174,
                child: Wrap(
                  children: [
                    Text(
                      movie.title,
                      style: GoogleFonts.getFont('Mitr',
                          color: AppColors.text,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 8,
              child: Container(
                width: 180,
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
