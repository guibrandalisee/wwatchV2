import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wwatch/Screens/full_screen_image/full_screen_image.dart';
import 'package:wwatch/Screens/user/widgets/content_list_tile.dart';
import 'package:wwatch/Screens/user/widgets/movie_list.dart';
import 'package:wwatch/Screens/user/widgets/user_list_screen.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/Shared/models/user_model.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:wwatch/stores/user_store.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();

  final StyleStore styleStore = GetIt.I<StyleStore>();

  final UserStore userStore = GetIt.I<UserStore>();

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(userStore.sessionId);

    return Scaffold(
      backgroundColor: styleStore.backgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Observer(builder: (context) {
                      return AlertDialog(
                        backgroundColor: styleStore.backgroundColor,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Logout?",
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Are you sure you want to logout?",
                              style: GoogleFonts.getFont('Mitr',
                                  color: styleStore.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w100),
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: styleStore.primaryColor),
                            ),
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    styleStore.shapeColor!.withAlpha(100))),
                          ),
                          ElevatedButton(
                            onPressed: !userStore.loading
                                ? () async {
                                    final response =
                                        await userStore.deleteSession();
                                    Navigator.of(context).pop();
                                    if (response) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Logged Out"),
                                              backgroundColor:
                                                  styleStore.primaryColor));
                                      Navigator.of(context).pop();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Failed to delete session from TMDB servers, try again later"),
                                              backgroundColor:
                                                  Colors.redAccent));
                                    }
                                  }
                                : null,
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                  color: styleStore.textOnPrimaryColor),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  styleStore.primaryColor),
                            ),
                          ),
                        ],
                      );
                    });
                  });
            },
            icon: Icon(Icons.logout),
            splashRadius: 20,
          ),
        ],
        iconTheme: IconThemeData(
          color: settingsStore.brightness != CustomBrightness.amoled
              ? AppColors.textOnPrimaries[styleStore.colorIndex!]
              : styleStore.primaryColor,
        ),
        backgroundColor: settingsStore.brightness == CustomBrightness.amoled
            ? styleStore.backgroundColor
            : styleStore.primaryColor,
        title: Container(
          child: Hero(
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
        ),
      ),
      body: Observer(builder: (context) {
        if (userStore.loading)
          return LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              styleStore.primaryColor,
            ),
            backgroundColor: styleStore.backgroundColor,
          );
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 110,
                width: double.infinity,
              ),
              if (userStore.user!.avatar != null &&
                  userStore.user!.avatar!.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FullScreenImage(
                            path: userStore.user!.avatarType == AvatarType.tmdb
                                ? "https://image.tmdb.org/t/p/original/${userStore.user!.avatar}"
                                : "https://www.gravatar.com/avatar/${userStore.user!.avatar}?s=800")));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        border: Border.all(
                            color: styleStore.primaryColor!, width: 4)),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      backgroundImage: userStore.user!.avatarType ==
                              AvatarType.tmdb
                          ? CachedNetworkImageProvider(
                              "https://image.tmdb.org/t/p/h632/${userStore.user!.avatar}")
                          : Image.network(
                              "https://www.gravatar.com/avatar/${userStore.user!.avatar}?s=200",
                            ).image,
                    ),
                  ),
                ),
              if (userStore.user!.avatar == null ||
                  userStore.user!.avatar!.isEmpty)
                Container(
                  height: 128,
                  width: 128,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      border: Border.all(
                          color: styleStore.primaryColor!, width: 4)),
                  child: Center(
                    child: Text(
                      userStore.user!.username[0].toUpperCase(),
                      style: GoogleFonts.getFont('Mitr',
                          color: styleStore.primaryColor,
                          fontSize: 48,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              SizedBox(
                height: 16,
              ),

              Text(
                userStore.user!.username,
                style: GoogleFonts.getFont('Mitr',
                    color: styleStore.textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),
              ),

              SizedBox(
                height: 32,
              ),
              // //TODO deal with multiple pages
              // if (userStore.favoriteMovies.length > 0)
              //   MovieListWidget(
              //       refresh: () async {
              //         await userStore.getFavoriteContent(
              //             reset: true,
              //             mediaType: CustomContentType.MOVIE,
              //             page: 1);
              //       },
              //       contentType: CustomContentType.MOVIE,
              //       title: "Favorite Movies",
              //       prefs: settingsStore.prefs!,
              //       content: userStore.favoriteMovies),
              // if (userStore.favoriteTvShows.length > 0)
              //   MovieListWidget(
              //       refresh: () async {
              //         await userStore.getFavoriteContent(
              //             reset: true,
              //             mediaType: CustomContentType.TVSHOW,
              //             page: 1);
              //       },
              //       contentType: CustomContentType.TVSHOW,
              //       title: "Favorite TVShows",
              //       prefs: settingsStore.prefs!,
              //       content: userStore.favoriteTvShows),
              ContentListTile(
                title: "Favorite Content",
                icon: LineIcons.heart,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserListScreen(
                        children: [
                          //TODO deal with multiple pages
                          if (userStore.favoriteMovies.length > 0)
                            MovieListWidget(
                                first: true,
                                refresh: () async {
                                  await userStore.getFavoriteContent(
                                      reset: true,
                                      mediaType: CustomContentType.MOVIE,
                                      page: 1);
                                },
                                contentType: CustomContentType.MOVIE,
                                title: "Favorite Movies",
                                prefs: settingsStore.prefs!,
                                content: userStore.favoriteMovies),
                          if (userStore.favoriteTvShows.length > 0)
                            MovieListWidget(
                                refresh: () async {
                                  await userStore.getFavoriteContent(
                                      reset: true,
                                      mediaType: CustomContentType.TVSHOW,
                                      page: 1);
                                },
                                contentType: CustomContentType.TVSHOW,
                                title: "Favorite TVShows",
                                prefs: settingsStore.prefs!,
                                content: userStore.favoriteTvShows),
                        ],
                      ),
                    ),
                  );
                },
              ),
              ContentListTile(
                title: "Rated Content",
                icon: LineIcons.star,
                onTap: () {},
              ),
              ContentListTile(
                title: "WatchList",
                icon: LineIcons.film,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserListScreen(
                        children: [
                          //TODO deal with multiple pages
                          if (userStore.movieWatchList.length > 0)
                            MovieListWidget(
                                first: true,
                                refresh: () async {
                                  await userStore.getWatchList(
                                      reset: true,
                                      mediaType: CustomContentType.MOVIE,
                                      page: 1);
                                },
                                contentType: CustomContentType.MOVIE,
                                title: "Movies WatchList",
                                prefs: settingsStore.prefs!,
                                content: userStore.movieWatchList),
                          if (userStore.tvShowWatchList.length > 0)
                            MovieListWidget(
                                refresh: () async {
                                  await userStore.getWatchList(
                                      reset: true,
                                      mediaType: CustomContentType.TVSHOW,
                                      page: 1);
                                },
                                contentType: CustomContentType.TVSHOW,
                                title: "TVShows WatchList",
                                prefs: settingsStore.prefs!,
                                content: userStore.tvShowWatchList),
                        ],
                      ),
                    ),
                  );
                },
              ),
              ContentListTile(
                title: "Custom Lists",
                icon: LineIcons.list,
                onTap: () {},
              ),
              SizedBox(
                height: 56,
              )
            ],
          ),
        );
      }),
    );
  }
}

void _getUserDetails() async {
  if (userStore.user == null) {
    await userStore.getUserDetails();
  }
  if (userStore.favoriteMovies.length == 0) {
    userStore.getFavoriteContent(mediaType: CustomContentType.MOVIE, page: 1);
  }
  if (userStore.favoriteTvShows.length == 0) {
    userStore.getFavoriteContent(mediaType: CustomContentType.TVSHOW, page: 1);
  }
  if (userStore.movieWatchList.length == 0) {
    userStore.getWatchList(mediaType: CustomContentType.MOVIE, page: 1);
  }
  if (userStore.tvShowWatchList.length == 0) {
    userStore.getWatchList(mediaType: CustomContentType.TVSHOW, page: 1);
  }
}
