import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wwatch/Screens/home/components/movie_tile.dart';
import 'package:wwatch/Screens/home/components/movie_tile_list.dart';
import 'package:wwatch/Shared/models/movie_model.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';
import 'package:wwatch/stores/user_store.dart';

//TODO error screen
//loading animation
class MovieListWidget extends StatefulWidget {
  MovieListWidget({
    Key? key,
    required this.prefs,
    required this.contentType,
    required this.getContent,
    required this.getMoreContent,
  }) : super(key: key);
  final SharedPreferences prefs;
  final CustomContentType contentType;
  final Future<List<SimpleMovie>> Function() getContent;
  final Future<List<SimpleMovie>> Function(int page) getMoreContent;

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final UserStore userStore = GetIt.I<UserStore>();

  final ScrollController scrollController = ScrollController();

  final StyleStore styleStore = GetIt.I<StyleStore>();

  bool scrollInProgress = false;

  bool refreshing = false;

  int currentPage = 1;
  List<SimpleMovie> content = [];

  Future<void> _getContent() async {
    content = await widget.getContent();
  }

  bool lastPage = false;
  Future<void> _getmoreContent(int page) async {
    final _content = await widget.getMoreContent(page);
    if (_content.isNotEmpty) {
      content = _content;
    } else {
      lastPage = true;
    }
  }

  @override
  void initState() {
    _getContent().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (content.length > 0) {
      return Stack(
        children: [
          ListView.builder(
            controller: scrollController,
            physics: BouncingScrollPhysics(),
            itemCount: content.length + 2,
            itemBuilder: (
              context,
              index,
            ) {
              if (index == 0)
                return SizedBox(
                  height: 64,
                );
              if (index == content.length + 1) if (!lastPage) {
                _getmoreContent(currentPage + 1).whenComplete(() {
                  currentPage += 1;
                  setState(() {});
                });
                return LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    styleStore.primaryColor,
                  ),
                  backgroundColor: styleStore.backgroundColor,
                );
              } else {
                return Container();
              }

              return settingsStore.tileDisplayMode == 0
                  ? MovieTile(
                      prefs: widget.prefs,
                      movie: content[index - 1],
                      contentType: widget.contentType,
                    )
                  : MovieTileList(
                      prefs: widget.prefs,
                      movie: content[index - 1],
                      contentType: widget.contentType);
            },
          ),
          Positioned(
            top: 16,
            right: 16,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(360),
                  )),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  backgroundColor:
                      MaterialStateProperty.all(styleStore.primaryColor)),
              onPressed: () async {
                setState(() {
                  refreshing = true;
                });
                content = await widget.getContent();
                lastPage = false;
                currentPage = 1;
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
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: styleStore.textColor,
                            ),
                          ),
                        )
                      ]
                    : [
                        Icon(
                          Icons.refresh,
                          color: styleStore.textColor,
                        ),
                      ],
              ),
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
