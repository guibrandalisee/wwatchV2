import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wwatch/Screens/movie/movie_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:wwatch/stores/user_store.dart';

class MovieListWidget extends StatefulWidget {
  MovieListWidget(
      {Key? key,
      required this.prefs,
      required this.content,
      required this.title,
      required this.refresh,
      required this.contentType,
      this.first = false})
      : super(key: key);
  final SharedPreferences prefs;
  final List<SimpleMovie> content;
  final String title;
  final Function refresh;
  final CustomContentType contentType;
  bool first;

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final UserStore userStore = GetIt.I<UserStore>();

  final ScrollController scrollController = ScrollController();

  final StyleStore styleStore = GetIt.I<StyleStore>();

  bool scrollInProgress = false;

  bool refreshing = false;

  @override
  Widget build(BuildContext context) {
    if (widget.content.length > 0) {
      return Column(
        children: [
          if (!widget.first)
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.getFont('Mitr',
                        color: styleStore.textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w400),
                  ),
                  Row(
                    children: [
                      if (widget.content.length > 1)
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
                      SizedBox(
                        width: 32,
                      ),
                      if (widget.content.length > 1)
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
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: styleStore.shapeColor),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.content.length,
              itemBuilder: (
                context,
                index,
              ) {
                return SizedBox(
                    width: 200,
                    child: MovieTileUserScreen(
                      contentType: widget.contentType,
                      prefs: widget.prefs,
                      movie: widget.content[index],
                    ));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      backgroundColor: MaterialStateProperty.all(
                          styleStore.primaryColor!.withOpacity(0.1))),
                  onPressed: () async {
                    setState(() {
                      refreshing = true;
                    });
                    await widget.refresh();
                    setState(() {
                      refreshing = false;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: refreshing
                        ? [
                            Container(
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: styleStore.textColor,
                                ),
                              ),
                            )
                          ]
                        : [
                            Text(
                              "refresh",
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w100),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.refresh,
                              color: styleStore.textColor,
                            ),
                          ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}

class MovieTileUserScreen extends StatelessWidget {
  final SimpleMovie movie;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final SharedPreferences prefs;
  final CustomContentType contentType;

  MovieTileUserScreen({
    Key? key,
    required this.movie,
    required this.prefs,
    required this.contentType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String formattedData = '';
    if (movie.releaseDate != null && movie.releaseDate!.length == 10) {
      switch (settingsStore.dateFormat) {
        case 'dd/mm/yyyy':
          formattedData =
              '${movie.releaseDate!.substring(8, 10)}/${movie.releaseDate!.substring(5, 7)}/${movie.releaseDate!.substring(0, 4)}';
          break;
        case 'mm/dd/yyyy':
          formattedData =
              '${movie.releaseDate!.substring(5, 7)}/${movie.releaseDate!.substring(8, 10)}/${movie.releaseDate!.substring(0, 4)}';
          break;
        case 'yyyy/mm/dd':
          formattedData = movie.releaseDate!.replaceAll('-', '/');
          break;
        default:
      }
    }

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(8),
      width: 500,
      height: 550,
      child: GestureDetector(
        onTap: Feedback.wrapForTap(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieScreen(
                prefs: prefs,
                movieId: movie.id,
                contentType: contentType == CustomContentType.MOVIE ? 0 : 1,
              ),
            ),
          );
        }, context),
        child: Stack(
          children: [
            movie.posterPath != null
                ? Container(
                    width: 500,
                    height: 550,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w342${movie.posterPath}',
                          filterQuality: FilterQuality.medium,
                          fit: BoxFit.cover,
                        )),
                  )
                : Center(
                    child: Container(
                      child: Text(
                        'No Image :(',
                        style: GoogleFonts.getFont('Mitr',
                            color: AppColors.text,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
            ClipRRect(
              //One less than on the CachedImage ClipRRect because
              //flutter is not pixel perfect when using stacks
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                ),
              ),
            ),
            Positioned(
              bottom: 45,
              left: 8,
              child: Container(
                width: 174,
                child: Wrap(
                  children: [
                    Text(
                      movie.title,
                      style: GoogleFonts.getFont('Mitr',
                          color: AppColors.text,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 8,
              child: Container(
                width: 180,
                child: Wrap(
                  children: [
                    Text(
                      formattedData,
                      style: GoogleFonts.getFont(
                        'Kodchasan',
                        color: AppColors.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
