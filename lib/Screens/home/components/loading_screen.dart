import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:wwatch/stores/style_store.dart';

class CustomLoadingScreen extends StatelessWidget {
  const CustomLoadingScreen({
    Key? key,
  }) : super(key: key);

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
            height: 48,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            clipBehavior: Clip.antiAlias,
            child: Shimmer(
              child: Container(height: 48, width: double.infinity),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            clipBehavior: Clip.antiAlias,
            child: Shimmer(
              child: Container(height: 48, width: double.infinity),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    clipBehavior: Clip.antiAlias,
                    child: Shimmer(
                      child: Container(
                        height: 48,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    clipBehavior: Clip.antiAlias,
                    child: Shimmer(
                      child: Container(
                        height: 48,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
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
