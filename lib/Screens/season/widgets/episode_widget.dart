import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/tv_season_model.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';

class EpisodeWidget extends StatelessWidget {
  EpisodeWidget({
    Key? key,
    required this.movieStore,
    required this.index,
  }) : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final MovieStore movieStore;
  final int index;
  String formatDate(Episode episode) {
    switch (settingsStore.dateFormat) {
      case 'dd/mm/yyyy':
        return '${episode.airDate.substring(8, 10)}/${episode.airDate.substring(5, 7)}/${episode.airDate.substring(0, 4)}';

      case 'mm/dd/yyyy':
        return '${episode.airDate.substring(5, 7)}/${episode.airDate.substring(8, 10)}/${episode.airDate.substring(0, 4)}';

      case 'yyyy/mm/dd':
        return episode.airDate.replaceAll('-', '/');
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: styleStore.shapeColor, borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: styleStore.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              height: 8,
            ),
            Container(
              height: 130,
              child: Row(
                children: [
                  movieStore.season!.episodes![index - 1].stillPath != null &&
                          movieStore.season!.episodes![index - 1].stillPath !=
                              ''
                      ? Container(
                          width: 200,
                          padding: EdgeInsets.all(12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w342${movieStore.season!.episodes![index - 1].stillPath}',
                              filterQuality: FilterQuality.medium,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          width: 200,
                          padding: EdgeInsets.all(8),
                          child: Container(
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                'No Image :(',
                                style: GoogleFonts.getFont('Mitr',
                                    color: styleStore.textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 250,
                          height: 62,
                          margin: EdgeInsets.all(8),
                          child: Wrap(
                            children: [
                              Text(
                                '$index - ${movieStore.season!.episodes![index - 1].name}',
                                style: GoogleFonts.getFont('Mitr',
                                    color: AppColors.text,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 240,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: styleStore.backgroundColor),
                          clipBehavior: Clip.antiAlias,
                          height: 4,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 240,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 72,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 1),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.shape,
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                      color: styleStore.primaryColor!,
                                      width: 2),
                                ),
                                child: Text(
                                  '${movieStore.season!.episodes![index - 1].voteAverage.toStringAsFixed(1)}/10',
                                  style: GoogleFonts.getFont('Mitr',
                                      color: AppColors.text,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 4,
                                ),
                                child: Text(
                                  formatDate(movieStore
                                          .season!.episodes![index - 1])
                                      .trim(),
                                  style: GoogleFonts.getFont('Mitr',
                                      color: AppColors.text,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w200),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: Wrap(
                children: [
                  Text(
                    movieStore.season!.episodes![index - 1].overview,
                    style: GoogleFonts.getFont('Mitr',
                        color: AppColors.text,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                    maxLines: 99,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
