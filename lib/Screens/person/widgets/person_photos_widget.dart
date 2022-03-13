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
        Container(
          padding: EdgeInsets.only(
            left: 16,
          ),
          child: Text(
            AppLocalizations.of(context)!.photos,
            style: GoogleFonts.getFont('Mitr',
                color: styleStore.textColor,
                fontSize: 20,
                fontWeight: FontWeight.w300),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
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
                        )),
                  ),
                );
              })),
        ),
      ],
    );
  }
}
