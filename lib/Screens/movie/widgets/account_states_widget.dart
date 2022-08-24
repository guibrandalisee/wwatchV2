import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class AccountStatesWidget extends StatelessWidget {
  AccountStatesWidget(
      {Key? key,
      required this.favorite,
      required this.watchlist,
      this.rate,
      required this.contentType})
      : super(key: key);
  final bool favorite;
  final bool watchlist;
  final num? rate;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final CustomContentType contentType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: Column(
        children: [
          Divider(
            color: AppColors.divider,
            thickness: 1,
            endIndent: 8,
            indent: 8,
          ),
          if (favorite)
            SizedBox(
              height: 12,
            ),
          if (favorite)
            Row(
              children: [
                Icon(
                  LineIcons.heart,
                  color: styleStore.primaryColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  contentType == CustomContentType.MOVIE
                      ? "Movie" + ' marked as favorite'
                      : "TV Show" + ' marked as favorite',
                  style: GoogleFonts.mitr(
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
          if (watchlist)
            SizedBox(
              height: 12,
            ),
          if (watchlist)
            Row(
              children: [
                Icon(
                  LineIcons.bookmark,
                  color: styleStore.primaryColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  contentType == CustomContentType.MOVIE
                      ? "Movie" + " added to watchlist"
                      : "TV Show" + " added to watchlist",
                  style: GoogleFonts.mitr(
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
          if (rate != null)
            SizedBox(
              height: 12,
            ),
          if (rate != null)
            Row(
              children: [
                Icon(
                  LineIcons.star,
                  color: styleStore.primaryColor,
                ),
                SizedBox(
                  width: 8,
                ),
                RichText(
                    text: TextSpan(
                        text: "Your rating: ",
                        style: GoogleFonts.mitr(
                            color: styleStore.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w100),
                        children: [
                      TextSpan(
                        text: rate.toString(),
                        style: GoogleFonts.mitr(
                            color: styleStore.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w200),
                      )
                    ])),
              ],
            ),
        ],
      ),
    );
  }
}
