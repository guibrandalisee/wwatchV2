import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Screens/home/components/content_filter_widget.dart';
import 'package:wwatch/Screens/home/components/loading_screen.dart';
import 'package:wwatch/Screens/home/components/error_screen.dart';
import 'package:wwatch/Screens/home/components/nothing_found_error_screen.dart';
import 'package:wwatch/Screens/home/components/speed_dial.dart';
import 'package:wwatch/Screens/login/login_screen.dart';
import 'package:wwatch/Screens/settings/settings_screen.dart';
import 'package:wwatch/Screens/welcome/welcome_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Screens/home/components/movie_tile.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:mobx/mobx.dart';

//TODO ask the user if he really wants to leave the app when pressing the back button on home screen
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
      settingsStore.setSelectedContentType(1);
    }
    movieStore.getPopularMovies();
    settingsStore.getMovieGenres();
  }

  final FocusNode focusNode = FocusNode();
  final MovieStore movieStore = MovieStore();

  final StyleStore styleStore = GetIt.I<StyleStore>();
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();

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
      floatingActionButton: CustomSpeedDialHomeScreen(
        movieStore: movieStore,
        focusNode: focusNode,
        scrollController: scrollController,
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
            child: Image.asset(
              "assets/images/WWatch2-png.png",
              filterQuality: FilterQuality.medium,
              color: settingsStore.brightness != CustomBrightness.amoled
                  ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                  : styleStore.primaryColor,
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
                  : styleStore.primaryColor,
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
            icon: Hero(
              tag: 'User Profile',
              child: Icon(
                LineIcons.user,
                color: settingsStore.brightness != CustomBrightness.amoled
                    ? AppColors.textOnPrimaries[styleStore.colorIndex!]
                    : styleStore.primaryColor,
                size: 28,
              ),
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
              return CustomErrorScree(
                movieStore: movieStore,
              );
            if (movieStore.empty)
              return CustomNothingFoundErrorScreen(
                movieStore: movieStore,
                focusNode: focusNode,
              );
            if (movieStore.movies.length == 0)
              return CustomLoadingScreen(
                movieStore: movieStore,
                focusNode: focusNode,
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
                            const SizedBox(
                              height: 28,
                            ),
                            ContentFilter(
                              focusNode: focusNode,
                              movieStore: movieStore,
                            ),
                          ],
                        );
                      else if (index < movieStore.movies.length + 1)
                        return MovieTile(
                          movie: movieStore.movies[index - 1],
                          contentType: settingsStore.selectedContentType,
                        );
                      else if (movieStore.totalPages != null &&
                          movieStore.page < movieStore.totalPages!) {
                        movieStore.getMorePopularMovies();
                        return LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            styleStore.primaryColor,
                          ),
                          backgroundColor: styleStore.backgroundColor,
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
                        padding: const EdgeInsets.symmetric(
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
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
