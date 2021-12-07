import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/style_store.dart';

class CustomLoadingMovieScreen extends StatelessWidget {
  const CustomLoadingMovieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StyleStore styleStore = GetIt.I<StyleStore>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              styleStore.primaryColor,
            ),
            backgroundColor: styleStore.primaryColor!.withAlpha(100),
          ),
          Container(
            height: 300,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Positioned(
                  bottom: 56,
                  left: 8,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(16)),
                    child: Shimmer(
                      child: Container(
                        height: 40,
                        width: 180,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  height: 30,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Shimmer(
                            child: Container(
                              height: 18,
                              width: 96,
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            margin: const EdgeInsets.only(left: 16),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: Shimmer(
              child: Container(
                height: 32,
                width: 180,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 16),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: Shimmer(
              child: Container(
                height: 190,
                width: 128,
              ),
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          Divider(
            color: AppColors.divider,
            thickness: 1,
            endIndent: 24,
            indent: 24,
          ),
          const SizedBox(
            height: 45,
          ),
        ],
      ),
    );
  }
}
