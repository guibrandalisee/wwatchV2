import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:line_icons/line_icons.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:wwatch/Screens/home/components/content_filter_widget.dart';
import 'package:wwatch/Screens/login/login_screen.dart';
import 'package:wwatch/Screens/settings/settings_screen.dart';
import 'package:wwatch/Screens/welcome/welcome_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/Widgets/movie_tile.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:mobx/mobx.dart';

//TODO add custom widgets to reduce number of lines

enum type { movie, tvShows }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.contentType}) : super(key: key);
  final contentType;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.contentType != type.movie) {
      movieStore.setSelectedContentType(1);
    }
    movieStore.getPopularMovies();
  }

  FocusNode focusNode = FocusNode();
  MovieStore movieStore = MovieStore();

  StyleStore styleStore = GetIt.I<StyleStore>();
  SettingsStore settingsStore = GetIt.I<SettingsStore>();

  late ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    reaction((_) => styleStore.fabPosition, (value) {
      setState(() {});
    });
    reaction((_) => styleStore.primaryColor, (value) {
      setState(() {});
    });
    reaction((_) => settingsStore.dateFormat, (value) {
      setState(() {});
    });
    reaction((_) => styleStore.backgroundColor, (value) {
      setState(() {});
    });
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (movieStore.backToTheTopVisible) {
            setState(() {
              movieStore.backToTheTopVisible = false;
            });
          }
        } else {
          if (!movieStore.backToTheTopVisible) {
            setState(() {
              movieStore.backToTheTopVisible = true;
            });
          }
        }
        if (scrollController.position.pixels < 1000) {
          movieStore.backToTheTopVisible = false;
        }
      });

    return Scaffold(
        floatingActionButtonLocation: styleStore.fabPosition == 0
            ? FloatingActionButtonLocation.startFloat
            : FloatingActionButtonLocation.endFloat,
        floatingActionButton: SpeedDial(
          tooltip: 'Navigation Menu',
          switchLabelPosition: styleStore.fabPosition == 0 ? true : false,
          spaceBetweenChildren: 16,
          overlayColor: Colors.black.withOpacity(0.1),
          backgroundColor: styleStore.primaryColor,
          iconTheme: IconThemeData(
            color: AppColors.textOnPrimaries[styleStore.colorIndex!],
          ),
          icon: Icons.menu,
          activeIcon: Icons.close,
          children: [
            SpeedDialChild(
              onTap: () async {
                // focusNode.requestFocus();
                FocusScope.of(context).unfocus();

                try {
                  await scrollController.animateTo(0,
                      duration: Duration(seconds: 1), curve: Curves.ease);
                } catch (e) {
                  print('noScroll');
                }

                FocusScope.of(context).requestFocus(focusNode);
              },
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Search',
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
              child: Icon(
                LineIcons.search,
                color: AppColors.textOnPrimaries[styleStore.colorIndex!],
              ),
              backgroundColor: styleStore.primaryColor,
            ),
            SpeedDialChild(
              onTap: () {},
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Movies',
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
              child: Icon(
                LineIcons.video,
                color: AppColors.textOnPrimaries[styleStore.colorIndex!],
              ),
              backgroundColor: styleStore.primaryColor,
            ),
            SpeedDialChild(
              onTap: () {},
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'TV Shows',
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
              child: Icon(
                LineIcons.television,
                color: AppColors.textOnPrimaries[styleStore.colorIndex!],
              ),
              backgroundColor: styleStore.primaryColor,
            ),
            SpeedDialChild(
              onTap: () {},
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Popular',
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
              child: Icon(
                LineIcons.lineChart,
                color: AppColors.textOnPrimaries[styleStore.colorIndex!],
              ),
              backgroundColor: styleStore.primaryColor,
            ),
            SpeedDialChild(
              onTap: () {},
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Upcoming',
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
              child: Icon(
                LineIcons.clock,
                color: AppColors.textOnPrimaries[styleStore.colorIndex!],
              ),
              backgroundColor: styleStore.primaryColor,
            ),
            SpeedDialChild(
              onTap: () {},
              labelWidget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'People',
                  style: GoogleFonts.getFont('Mitr',
                      color: styleStore.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              ),
              child: Icon(
                LineIcons.users,
                color: AppColors.textOnPrimaries[styleStore.colorIndex!],
              ),
              backgroundColor: styleStore.primaryColor,
            ),
          ],
        ),
        backgroundColor: styleStore.backgroundColor,
        appBar: AppBar(
          backgroundColor: settingsStore.brightness == CustomBrightness.amoled
              ? styleStore.backgroundColor
              : styleStore.primaryColor,
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
              );
            },
            child: Ink(
              child: Hero(
                tag: "logo",
                child: Image.asset(
                  "assets/images/WWatch2-png.png",
                  filterQuality: FilterQuality.medium,
                  color: settingsStore.brightness != CustomBrightness.amoled
                      ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                      : AppColors.text,
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              splashRadius: 20,
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
              icon: Icon(
                LineIcons.cog,
                color: settingsStore.brightness != CustomBrightness.amoled
                    ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                    : AppColors.text,
                size: 28,
              ),
            ),
            IconButton(
              splashRadius: 20,
              tooltip: 'User Profile',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(
                LineIcons.user,
                color: settingsStore.brightness != CustomBrightness.amoled
                    ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                    : AppColors.text,
                size: 28,
              ),
            ),
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            if (movieStore.searchString.isNotEmpty) {
              movieStore.setSearch('');
              movieStore.search();
              return false;
            }
            return true;
          },
          child: Observer(
            builder: (context) {
              if (movieStore.error)
                return Center(
                  child: Container(
                    margin: EdgeInsets.all(32),
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: styleStore.shapeColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ERROR',
                          style: GoogleFonts.getFont('Mitr',
                              color: styleStore.textColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          height: 120,
                          child: SvgPicture.asset(
                            styleStore.errorImage!,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "We couldn't connect you to the TMDB servers",
                          style: GoogleFonts.getFont('Mitr',
                              color: styleStore.textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "verify your internet connection and try again",
                          style: GoogleFonts.getFont('Mitr',
                              color: styleStore.textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w100),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Container(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    styleStore.primaryColor)),
                            onPressed: () {
                              movieStore.error = false;
                              movieStore.getPopularMovies();
                            },
                            child: Text(
                              "Try Again",
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              if (movieStore.empty)
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 28,
                      ),
                      ContentFilter(
                        focusNode: focusNode,
                        movieStore: movieStore,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.all(32),
                          padding: EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: styleStore.shapeColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 32,
                              ),
                              Container(
                                height: 120,
                                child: SvgPicture.asset(
                                  styleStore.nothingFoundImage!,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Text(
                                "Couldn't find any movies with the especified filters :(",
                                style: GoogleFonts.getFont('Mitr',
                                    color: styleStore.textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              if (movieStore.movies.length == 0)
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          styleStore.primaryColor,
                        ),
                        backgroundColor:
                            styleStore.primaryColor!.withAlpha(100),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ContentFilter(
                        focusNode: focusNode,
                        movieStore: movieStore,
                      ),
                      Container(
                        margin: EdgeInsets.all(16),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Shimmer(
                          child: Container(
                            height: 550,
                            width: 500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              return Stack(
                children: [
                  ListView.builder(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      itemCount: movieStore.movies.length + 2,
                      itemBuilder: (context, index) {
                        if (index == 0)
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 28,
                              ),
                              ContentFilter(
                                focusNode: focusNode,
                                movieStore: movieStore,
                              ),
                            ],
                          );
                        else if (index < movieStore.movies.length + 1)
                          return MovieTile(movie: movieStore.movies[index - 1]);
                        else if (movieStore.totalPages != null &&
                            movieStore.page < movieStore.totalPages!) {
                          movieStore.getMorePopularMovies();
                          return LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                              styleStore.primaryColor,
                            ),
                            backgroundColor:
                                styleStore.primaryColor!.withAlpha(100),
                          );
                        } else {
                          return Container();
                        }
                      }),
                  Visibility(
                    visible: movieStore.backToTheTopVisible,
                    child: Positioned(
                        right: styleStore.fabPosition == 1 ? 20 : null,
                        left: styleStore.fabPosition == 0 ? 20 : null,
                        bottom: 128,
                        child: InkWell(
                          onTap: () {
                            //TODO add an animation to this button
                            scrollController.animateTo(0,
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.easeInOut);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                                color: AppColors.shape,
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                    color: styleStore.primaryColor!, width: 2)),
                            child: Icon(
                              LineIcons.arrowUp,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
