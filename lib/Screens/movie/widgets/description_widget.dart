import 'package:cached_network_image/cached_network_image.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Screens/full_screen_image/full_screen_image.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DescriptionWidget extends StatelessWidget {
  DescriptionWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final CompleteMovie movie;

  @override
  Widget build(BuildContext context) {
    final styleStore = GetIt.I<StyleStore>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (settingsStore.selectedContentType == 0)
          Container(
              margin: EdgeInsets.only(left: 32, right: 32, bottom: 16),
              padding: EdgeInsets.all(4),
              alignment: Alignment.center,
              height: 32,
              decoration: BoxDecoration(
                color: styleStore.shapeColor,
                borderRadius: BorderRadius.circular(32),
              ),
              child: RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!.status,
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${movie.launchStatus}',
                      style: GoogleFonts.getFont('Kodchasan',
                          color: styleStore.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )),

        //TODO find out how to get movie Age Certifications
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: double.infinity,
            child: Text(
              movie.title,
              style: GoogleFonts.getFont('Mitr',
                  color: styleStore.textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropCapText(
            movie.overview,
            style: GoogleFonts.getFont('Mitr',
                color: styleStore.textColor,
                fontSize: 20,
                fontWeight: FontWeight.w300),
            dropCapPadding: const EdgeInsets.only(right: 16, bottom: 8),
            dropCap: DropCap(
                child: movie.posterPath != null
                    ? InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FullScreenImage(
                                  path:
                                      "https://image.tmdb.org/t/p/original${movie.posterPath}")));
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  memCacheHeight: 285,
                                  memCacheWidth: 189,
                                  filterQuality: FilterQuality.medium,
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w342${movie.posterPath}',
                                )),
                          ],
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          'No Image :(',
                          style: GoogleFonts.getFont('Mitr',
                              color: styleStore.textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                width: 128,
                height: 190),
          ),
        ),
      ],
    );
  }
}
