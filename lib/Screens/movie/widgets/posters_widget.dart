import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Screens/full_screen_image/full_screen_image.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostersWidget extends StatelessWidget {
  final CompleteMovie movie;
  PostersWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();
  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    return Container(
      constraints: BoxConstraints(maxWidth: 1080),
      child: Column(
        children: [
          Divider(
            color: AppColors.divider,
            thickness: 1,
            endIndent: 24,
            indent: 24,
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  settingsStore.selectedContentType == 0
                      ? AppLocalizations.of(context)!.moviePosters
                      : AppLocalizations.of(context)!.posters,
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                ),
                Row(
                  children: [
                    if (movie.images != null && movie.images!.length > 1)
                      IconButton(
                          splashRadius: 16,
                          onPressed: () {
                            carouselController.previousPage();
                          },
                          icon: Icon(
                            Icons.chevron_left_rounded,
                            color: styleStore.textColor,
                            size: 22,
                          )),
                    SizedBox(
                      width: 32,
                    ),
                    if (movie.images != null && movie.images!.length > 1)
                      IconButton(
                          splashRadius: 16,
                          onPressed: () {
                            carouselController.nextPage();
                          },
                          icon: Icon(
                            Icons.chevron_right_rounded,
                            color: styleStore.textColor,
                            size: 22,
                          )),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            child: CarouselSlider.builder(
              carouselController: carouselController,
              key: UniqueKey(),
              itemCount: movie.images!.length,
              itemBuilder: (context, index, realIdx) {
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                            path:
                                "https://image.tmdb.org/t/p/original${movie.images![index].filePath}")));
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${movie.images![index].filePath}',
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.medium,
                          ),
                          Positioned(
                            left: 8,
                            top: 8,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColors.shape.withAlpha(100)),
                              child: Icon(
                                LineIcons.alternateExpandArrows,
                                size: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          if (movie.images != null && movie.images!.length > 1)
                            Positioned(
                              right: 16,
                              top: 16,
                              child: Container(
                                  padding: EdgeInsets.all(4),
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: AppColors.shape,
                                      borderRadius: BorderRadius.circular(32),
                                      border: Border.all(
                                          color: styleStore.primaryColor!,
                                          width: 2)),
                                  child: Text(
                                    '${index + 1} / ${movie.images!.length}',
                                    style: GoogleFonts.getFont('Kodchasan',
                                        color: AppColors.text,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  )),
                            )
                        ],
                      )),
                );
              },
              options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  enableInfiniteScroll: false,
                  scrollDirection: Axis.horizontal,
                  aspectRatio: 7 / 9,
                  autoPlay: false,
                  enlargeCenterPage: true),
            ),
          ),
        ],
      ),
    );
  }
}
