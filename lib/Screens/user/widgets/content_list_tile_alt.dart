import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContentListTileAlt extends StatelessWidget {
  ContentListTileAlt(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onTapMovie,
      required this.onTapTvShow})
      : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final String title;
  final IconData icon;
  final VoidCallback onTapMovie;
  final VoidCallback onTapTvShow;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Icon(
                icon,
                color: styleStore.primaryColor,
                size: 28,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: GoogleFonts.mitr(
                  color: styleStore.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2 - 24,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(8),
                  color: styleStore.shapeColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.symmetric(
                      horizontal: BorderSide(
                          color: styleStore.primaryColor!, width: 0.5),
                      vertical: BorderSide(
                          color: styleStore.primaryColor!, width: 0.5)),
                ),
                padding: EdgeInsets.all(8),
                height: 48,
                child: InkWell(
                  onTap: onTapMovie,
                  child: Center(
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.movies,
                        style: GoogleFonts.mitr(
                          color: styleStore.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2 - 24,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(8),
                  color: styleStore.shapeColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.symmetric(
                      horizontal: BorderSide(
                          color: styleStore.primaryColor!, width: 0.5),
                      vertical: BorderSide(
                          color: styleStore.primaryColor!, width: 0.5)),
                ),
                padding: EdgeInsets.all(8),
                height: 48,
                child: InkWell(
                  onTap: onTapTvShow,
                  child: Center(
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.tvShows,
                        style: GoogleFonts.mitr(
                          color: styleStore.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
