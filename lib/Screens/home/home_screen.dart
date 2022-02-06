import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:get_it/get_it.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Screens/home/components/content_filter_widget.dart';
import 'package:wwatch/Screens/home/components/loading_screen.dart';
import 'package:wwatch/Screens/home/components/error_screen.dart';
import 'package:wwatch/Screens/home/components/movie_tile_list.dart';
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
    reaction((_) => settingsStore.tileDisplayMode, (value) {
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
            child: Center(
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
        child: DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text('Tap back again to leave'),
          ),
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
              if (movieStore.movies.length == 0) return CustomLoadingScreen();
              return ScrollWrapper(
                promptAlignment: styleStore.fabPosition == 1
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
                promptAnimationType: PromptAnimation.scale,
                promptTheme: PromptButtonTheme(
                    padding: EdgeInsets.symmetric(
                        vertical:
                            MediaQuery.of(context).viewPadding.bottom + 128,
                        horizontal: 24),
                    color: styleStore.primaryColor,
                    icon: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: AppColors.textOnPrimaries[styleStore.colorIndex!],
                    )),
                builder: (context, properties) => ListView.builder(
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
                        return settingsStore.tileDisplayMode == 0
                            ? MovieTile(
                                movie: movieStore.movies[index - 1],
                                contentType: settingsStore.selectedContentType,
                              )
                            : MovieTileList(
                                movie: movieStore.movies[index - 1],
                                contentType: settingsStore.selectedContentType);
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
              );
            },
          ),
        ),
      ),
    );
  }
}
