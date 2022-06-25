import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Screens/full_screen_image/full_screen_image.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonPhotosWidget extends StatelessWidget {
  PersonPhotosWidget({
    Key? key,
    required this.movieStore,
  }) : super(key: key);
  final MovieStore movieStore;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final ScrollController scrollController = ScrollController();
  bool scrollInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (movieStore.person!.images!.length > 1)
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
              AppLocalizations.of(context)!.photos,
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              width: 8,
            ),
            if (movieStore.person!.images!.length > 1)
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
        SizedBox(
          height: 16,
        ),
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: movieStore.person!.images!.length,
              itemBuilder: ((context, index) {
                if (index == 0) return Container();
                return GestureDetector(
                  onTap: Feedback.wrapForTap(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                            path:
                                "https://image.tmdb.org/t/p/original${movieStore.person!.images![index].filePath}")));
                  }, context),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: index == 1 ? 16 : 8,
                        right: index == movieStore.person!.images!.length
                            ? 16
                            : 8),
                    width: 200,
                    height: 550,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w342${movieStore.person!.images![index].filePath}',
                          filterQuality: FilterQuality.medium,
                          fit: BoxFit.cover,
                          memCacheHeight: 300,
                          memCacheWidth: 200,
                        )),
                  ),
                );
              })),
        ),
      ],
    );
  }
}
