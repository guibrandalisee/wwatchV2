import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Shared/models/movie_video_model.dart';
import 'package:wwatch/main.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrailersWidget extends StatefulWidget {
  final CompleteMovie movie;
  TrailersWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<TrailersWidget> createState() => _TrailersWidgetState();
}

class _TrailersWidgetState extends State<TrailersWidget> {
  CarouselController carouselController = CarouselController();
  final styleStore = GetIt.I<StyleStore>();
  final settingsStore = GetIt.I<SettingsStore>();

  @override
  Widget build(BuildContext context) {
    List<MovieVideo> videos = [];
    for (var item in widget.movie.videos!) {
      if (item.official) {
        videos.add(item);
      }
    }
    if (videos.length > 0)
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (videos.length > 1)
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
              Text(
                settingsStore.selectedContentType == 0
                    ? AppLocalizations.of(context)!.movieTrailers
                    : AppLocalizations.of(context)!.trailers,
                style: GoogleFonts.getFont('Mitr',
                    color: styleStore.textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w400),
              ),
              if (videos.length > 1)
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
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
              height: 250,
              width: 400,
              child: CarouselSlider.builder(
                key: UniqueKey(),
                carouselController: carouselController,
                itemCount: videos.length,
                itemBuilder: ((context, index, realIDX) {
                  return GestureDetector(
                    onTap: Feedback.wrapForTap(() {
                      launchInBrowser(
                          'https://www.youtube.com/watch?v=${videos[index].key}');
                    }, context),
                    child: Container(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://img.youtube.com/vi/${videos[index].key}/0.jpg',
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.medium,
                            ),
                          ),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                gradient: RadialGradient(colors: [
                              Colors.black.withAlpha(150),
                              Colors.transparent
                            ])),
                          ),
                          Icon(
                            LineIcons.youtube,
                            color: Colors.white,
                            size: 45,
                          ),
                          Positioned(
                            left: 16,
                            top: 4,
                            right: 16,
                            child: Text(
                              videos[index].name,
                              style: GoogleFonts.getFont('Mitr',
                                  color: AppColors.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 8,
                            right: 16,
                            child: Text(
                              AppLocalizations.of(context)!.watchOnYoutube,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.getFont('Mitr',
                                  color: AppColors.text,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w200),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                options: CarouselOptions(
                    scrollPhysics: BouncingScrollPhysics(),
                    aspectRatio: 16 / 10,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false),
              )),
        ],
      );
    else
      return Container();
  }
}
