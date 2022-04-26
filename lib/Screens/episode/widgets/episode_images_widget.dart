import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Screens/full_screen_image/full_screen_image.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/tv_season_model.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EpisodeImagesWidget extends StatelessWidget {
  final Episode episode;
  EpisodeImagesWidget({
    Key? key,
    required this.episode,
  }) : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();
  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    return Column(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (episode.images != null && episode.images!.length > 1)
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
              AppLocalizations.of(context)!.images,
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            if (episode.images != null && episode.images!.length > 1)
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
          child: CarouselSlider.builder(
            carouselController: carouselController,
            key: UniqueKey(),
            itemCount: episode.images!.length,
            itemBuilder: (context, index, realIdx) {
              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FullScreenImage(
                          path:
                              "https://image.tmdb.org/t/p/original${episode.images![index].filePath}")));
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${episode.images![index].filePath}',
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
                      ],
                    )),
              );
            },
            options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                aspectRatio: 16 / 9,
                autoPlay: false,
                enlargeCenterPage: true),
          ),
        ),
      ],
    );
  }
}
