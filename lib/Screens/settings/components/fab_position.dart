import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/style_store.dart';

class FabPosition extends StatelessWidget {
  const FabPosition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StyleStore styleStore = GetIt.I<StyleStore>();
    return Column(
      children: [
        Observer(
          builder: (_) {
            return Container(
              height: 56,
              decoration: BoxDecoration(
                  color: AppColors.button,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 56,
                      child: TextButton(
                        onPressed: () {
                          styleStore.setFabPosition(0);
                        },
                        child: Text(
                          "Left",
                          style: GoogleFonts.getFont('Mitr',
                              color: AppColors.text,
                              fontSize: 18,
                              fontWeight: FontWeight.w100),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                styleStore.fabPosition == 0
                                    ? styleStore.primaryColor
                                    : Colors.transparent)),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 36,
                    color: AppColors.text,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 56,
                      child: TextButton(
                        onPressed: () {
                          styleStore.setFabPosition(1);
                        },
                        child: Text(
                          "Right",
                          style: GoogleFonts.getFont('Mitr',
                              color: AppColors.text,
                              fontSize: 18,
                              fontWeight: FontWeight.w100),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                styleStore.fabPosition == 1
                                    ? styleStore.primaryColor
                                    : Colors.transparent)),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
