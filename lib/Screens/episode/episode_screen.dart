import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Screens/episode/widgets/episode_images_widget.dart';

import 'package:wwatch/Screens/full_screen_image/full_screen_image.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/tv_season_model.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO
//Credits
//Images
//Videos

class EpisodeScreen extends StatefulWidget {
  EpisodeScreen({
    Key? key,
    required this.movieStore,
    required this.tvId,
    required this.seasonNumber,
    required this.episodeNumber,
  }) : super(key: key);
  final MovieStore movieStore;
  final int tvId;
  final int seasonNumber;
  final int episodeNumber;
  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  @override
  void initState() {
    widget.movieStore
        .getEpisode(widget.tvId, widget.seasonNumber, widget.episodeNumber);

    super.initState();
  }

  final StyleStore styleStore = GetIt.I<StyleStore>();

  String formatDate(Episode episode) {
    String date = '';

    switch (settingsStore.dateFormat) {
      case 'dd/mm/yyyy':
        try {
          date =
              '${episode.airDate.substring(8, 10)}/${episode.airDate.substring(5, 7)}/${episode.airDate.substring(0, 4)}';
        } catch (e) {
          date = '';
        }
        break;
      case 'mm/dd/yyyy':
        try {
          date =
              '${episode.airDate.substring(5, 7)}/${episode.airDate.substring(8, 10)}/${episode.airDate.substring(0, 4)}';
        } catch (e) {
          date = '';
        }
        break;
      case 'yyyy/mm/dd':
        date = episode.airDate.replaceAll('-', '/');
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.movieStore.error = false;
        return true;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: styleStore.backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: settingsStore.brightness != CustomBrightness.amoled
                ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                : styleStore.primaryColor,
          ),
          backgroundColor: settingsStore.brightness == CustomBrightness.amoled
              ? styleStore.backgroundColor
              : styleStore.primaryColor,
          title: Hero(
            tag: "logo",
            child: SizedBox(
              height: 56,
              child: Image(
                image: ResizeImage(
                    AssetImage(
                      'assets/images/WWatch2-png.png',
                    ),
                    height: 156,
                    width: 156),
                filterQuality: FilterQuality.medium,
                color: settingsStore.brightness != CustomBrightness.amoled
                    ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                    : styleStore.primaryColor,
              ),
            ),
          ),
          actions: [],
        ),
        body: Observer(builder: (context) {
          if (widget.movieStore.loadingEpisode)
            return LinearProgressIndicator(
              color: styleStore.primaryColor,
              backgroundColor: styleStore.backgroundColor,
            );

          if (widget.movieStore.episodeError)
            //TODO impletment error screen
            return Center(
              child: Text('ERROR'),
            );

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      widget.movieStore.episode!.name,
                      style: GoogleFonts.getFont('Mitr',
                          color: styleStore.textColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                if (widget.movieStore.episode!.stillPath != null &&
                    widget.movieStore.episode!.stillPath != '')
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FullScreenImage(
                                path:
                                    "https://image.tmdb.org/t/p/original${widget.movieStore.episode!.stillPath!}")));
                      },
                      child: Container(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w780${widget.movieStore.episode!.stillPath!}',
                        ),
                      )),
                    ),
                  ),
                if (widget.movieStore.episode!.stillPath == null ||
                    widget.movieStore.episode!.stillPath == '')
                  Container(
                    width: double.infinity,
                    height: 220,
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: styleStore.shapeColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        'No Image :(',
                        style: GoogleFonts.getFont('Mitr',
                            color: styleStore.textColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 1),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.shape,
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                                color: styleStore.primaryColor!, width: 2),
                          ),
                          child: Text(
                            '${widget.movieStore.episode!.voteAverage.toStringAsFixed(1)}/10',
                            style: GoogleFonts.getFont('Mitr',
                                color: AppColors.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 32,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: styleStore.shapeColor),
                            child: Center(
                              child: Text(
                                "${AppLocalizations.of(context)!.episode} ${widget.movieStore.episode!.episodeNumber}",
                                style: GoogleFonts.getFont('Mitr',
                                    color: styleStore.textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: 4,
                          ),
                          child: Text(
                            formatDate(widget.movieStore.episode!).trim(),
                            style: GoogleFonts.getFont('Mitr',
                                color: styleStore.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 32,
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: styleStore.shapeColor),
                            child: Center(
                              child: Text(
                                "${AppLocalizations.of(context)!.season} ${widget.movieStore.episode!.seasonNumber}",
                                style: GoogleFonts.getFont('Mitr',
                                    color: styleStore.textColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    widget.movieStore.episode!.overview,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                if (widget.movieStore.episode!.images != null &&
                    widget.movieStore.episode!.images!.length > 1)
                  EpisodeImagesWidget(episode: widget.movieStore.episode!),
                SizedBox(
                  height: 64,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
