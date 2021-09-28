import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/style_store.dart';

class ColorSelector extends StatelessWidget {
  const ColorSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StyleStore styleStore = GetIt.I<StyleStore>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(24),
              child: Ink(
                decoration: BoxDecoration(
                    color: AppColors.primaries[0],
                    borderRadius: BorderRadius.circular(24)),
                height: 80,
                width: 80,
                child: Center(
                  child: styleStore.colorIndex == 0
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : Container(),
                ),
              ),
              onTap: () {
                styleStore.setPrimaryColor(AppColors.primaries[0], 0);
              },
            ),
            InkWell(
              borderRadius: BorderRadius.circular(24),
              child: Ink(
                decoration: BoxDecoration(
                    color: AppColors.primaries[1],
                    borderRadius: BorderRadius.circular(24)),
                height: 80,
                width: 80,
                child: Center(
                  child: styleStore.colorIndex == 1
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : Container(),
                ),
              ),
              onTap: () {
                styleStore.setPrimaryColor(AppColors.primaries[1], 1);
              },
            ),
            InkWell(
              borderRadius: BorderRadius.circular(24),
              child: Ink(
                decoration: BoxDecoration(
                    color: AppColors.primaries[2],
                    borderRadius: BorderRadius.circular(24)),
                height: 80,
                width: 80,
                child: Center(
                  child: styleStore.colorIndex == 2
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : Container(),
                ),
              ),
              onTap: () {
                styleStore.setPrimaryColor(AppColors.primaries[2], 2);
              },
            ),
            InkWell(
              borderRadius: BorderRadius.circular(24),
              child: Ink(
                decoration: BoxDecoration(
                    color: AppColors.primaries[3],
                    borderRadius: BorderRadius.circular(24)),
                height: 80,
                width: 80,
                child: Center(
                  child: styleStore.colorIndex == 3
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : Container(),
                ),
              ),
              onTap: () {
                styleStore.setPrimaryColor(AppColors.primaries[3], 3);
              },
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(24),
              child: Ink(
                decoration: BoxDecoration(
                    color: AppColors.primaries[4],
                    borderRadius: BorderRadius.circular(24)),
                height: 80,
                width: 80,
                child: Center(
                  child: styleStore.colorIndex == 4
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : Container(),
                ),
              ),
              onTap: () {
                styleStore.setPrimaryColor(AppColors.primaries[4], 4);
              },
            ),
            InkWell(
              borderRadius: BorderRadius.circular(24),
              child: Ink(
                decoration: BoxDecoration(
                    color: AppColors.primaries[5],
                    borderRadius: BorderRadius.circular(24)),
                height: 80,
                width: 80,
                child: Center(
                  child: styleStore.colorIndex == 5
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : Container(),
                ),
              ),
              onTap: () {
                styleStore.setPrimaryColor(AppColors.primaries[5], 5);
              },
            ),
            InkWell(
              borderRadius: BorderRadius.circular(24),
              child: Ink(
                decoration: BoxDecoration(
                    color: AppColors.primaries[6],
                    borderRadius: BorderRadius.circular(24)),
                height: 80,
                width: 80,
                child: Center(
                  child: styleStore.colorIndex == 6
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : Container(),
                ),
              ),
              onTap: () {
                styleStore.setPrimaryColor(AppColors.primaries[6], 6);
              },
            ),
            InkWell(
              borderRadius: BorderRadius.circular(24),
              child: Ink(
                decoration: BoxDecoration(
                    color: AppColors.primaries[7],
                    borderRadius: BorderRadius.circular(24)),
                height: 80,
                width: 80,
                child: Center(
                  child: styleStore.colorIndex == 7
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : Container(),
                ),
              ),
              onTap: () {
                styleStore.setPrimaryColor(AppColors.primaries[7], 7);
              },
            ),
          ],
        ),
      ],
    );
  }
}
