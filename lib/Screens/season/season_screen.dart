import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Screens/full_screen_image/full_screen_image.dart';
import 'package:wwatch/Screens/season/widgets/episode_widget.dart';

import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class SeasonScreen extends StatefulWidget {
  SeasonScreen({
    Key? key,
    required this.tvId,
    required this.seasonNumber,
  }) : super(key: key);
  final int tvId;
  final int seasonNumber;

  @override
  State<SeasonScreen> createState() => _SeasonScreenState();
}

class _SeasonScreenState extends State<SeasonScreen> {
  @override
  void initState() {
    super.initState();
    movieStore.getSeasonEpisodes(
        tvId: widget.tvId, seasonNumber: widget.seasonNumber);
  }

  final StyleStore styleStore = GetIt.I<StyleStore>();

  final SettingsStore settingsStore = GetIt.I<SettingsStore>();

  final MovieStore movieStore = MovieStore();

  @override
  Widget build(BuildContext context) {
    print('TV id: ${widget.tvId}');
    print('Season Number: ${widget.seasonNumber}');
    return Scaffold(
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
      body: Observer(
        builder: (context) {
          if (movieStore.loadingSeason)
            return LinearProgressIndicator(
              color: styleStore.primaryColor,
              backgroundColor: styleStore.backgroundColor,
            );
          if (movieStore.season != null)
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: movieStore.season!.episodes!.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0)
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              movieStore.season!.name,
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: DropCapText(
                            movieStore.season!.overview,
                            style: GoogleFonts.getFont('Mitr',
                                color: styleStore.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                            dropCapPadding:
                                const EdgeInsets.only(right: 16, bottom: 8),
                            dropCap: DropCap(
                                child: movieStore.season!.posterPath != null
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullScreenImage(
                                                          path:
                                                              "https://image.tmdb.org/t/p/original${movieStore.season!.posterPath}")));
                                        },
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                'https://image.tmdb.org/t/p/w342${movieStore.season!.posterPath}',
                                                filterQuality:
                                                    FilterQuality.medium,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              left: 8,
                                              top: 8,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: AppColors.shape
                                                        .withAlpha(100)),
                                                child: Icon(
                                                  LineIcons
                                                      .alternateExpandArrows,
                                                  size: 22,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
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

                  if (movieStore.season!.episodes!.length > 0 &&
                      movieStore.season!.episodes != null)
                    return EpisodeWidget(
                      movieStore: movieStore,
                      index: index,
                    );
                  return Container();
                });
          //TODO make an error warning
          return Container();
        },
      ),
    );
  }
}
