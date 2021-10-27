import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:line_icons/line_icons.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:wwatch/Screens/login/login_screen.dart';
import 'package:wwatch/Screens/settings/settings_screen.dart';
import 'package:wwatch/Screens/welcome/welcome_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/Widgets/custom_fab.dart';
import 'package:wwatch/Shared/Widgets/movie_tile.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:mobx/mobx.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    movieStore.getPopularMovies();
  }

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
        floatingActionButton: CustomFAB(
          search: true,
          popular: true,
          genres: true,
          upcoming: true,
          tvshows: true,
          movies: true,
          people: true,
        ),
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: styleStore.primaryColor,
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
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
              icon: Icon(
                LineIcons.cog,
                color: AppColors.logo,
                size: 28,
              ),
            ),
            IconButton(
              tooltip: 'User Profile',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(
                LineIcons.user,
                color: AppColors.logo,
                size: 28,
              ),
            ),
          ],
        ),
        body: Observer(
          builder: (context) {
            if (movieStore.error)
              return Center(
                child: Container(
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.shape,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'ERROR',
                        style: GoogleFonts.getFont('Mitr',
                            color: AppColors.text,
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
                            color: AppColors.text,
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
                            color: AppColors.text,
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
                                color: AppColors.text,
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

            if (movieStore.popularMovies.length == 0)
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        styleStore.primaryColor,
                      ),
                      backgroundColor: styleStore.primaryColor!.withAlpha(100),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      child: Shimmer(
                        child: Container(
                          height: 75,
                          width: 340,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      child: Shimmer(
                        child: Container(
                          height: 75,
                          width: 340,
                        ),
                      ),
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
                    itemCount: movieStore.popularMovies.length + 2,
                    itemBuilder: (context, index) {
                      if (index == 0)
                        //TODO change this to a selector where the user can select if they want to see movies or TVShows
                        return Container();
                      else if (index < movieStore.popularMovies.length + 1)
                        return MovieTile(
                            movie: movieStore.popularMovies[index - 1]);
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
                      right: styleStore.fabPosition == 0 ? 16 : null,
                      left: styleStore.fabPosition == 1 ? 16 : null,
                      bottom: 32,
                      child: InkWell(
                        onTap: () {
                          //TODO add an animation to this button
                          scrollController.animateTo(0,
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeInOut);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
        ));
  }
}
