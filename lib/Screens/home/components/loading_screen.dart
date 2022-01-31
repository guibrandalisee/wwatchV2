import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:wwatch/Screens/home/components/content_filter_widget.dart';
import 'package:wwatch/stores/movie_store.dart';
import 'package:wwatch/stores/style_store.dart';

class CustomLoadingScreen extends StatelessWidget {
  const CustomLoadingScreen({
    Key? key,
    required this.movieStore,
    required this.focusNode,
  }) : super(key: key);
  final MovieStore movieStore;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context) {
    final StyleStore styleStore = GetIt.I<StyleStore>();
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              styleStore.primaryColor,
            ),
            backgroundColor: styleStore.backgroundColor,
          ),
          const SizedBox(
            height: 24,
          ),
          ContentFilter(
            focusNode: focusNode,
            movieStore: movieStore,
          ),
          Container(
            margin: const EdgeInsets.all(16),
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
  }
}
