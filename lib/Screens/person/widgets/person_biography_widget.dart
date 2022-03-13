import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonBiographyWidget extends StatelessWidget {
  PersonBiographyWidget({
    Key? key,
    required this.movieStore,
  }) : super(key: key);
  final MovieStore movieStore;
  final StyleStore styleStore = GetIt.I<StyleStore>();

  @override
  Widget build(BuildContext context) {
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
        Container(
          decoration: BoxDecoration(
              color: styleStore.shapeColor,
              borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.biography,
                style: GoogleFonts.getFont('Mitr',
                    color: styleStore.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 16,
              ),
              Wrap(
                children: [
                  Text(
                    movieStore.person!.biography!,
                    style: GoogleFonts.getFont(
                      'Mitr',
                      color: styleStore.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
                    ),
                    maxLines: 999,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
