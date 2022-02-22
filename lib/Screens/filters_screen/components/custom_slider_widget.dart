import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wwatch/stores/style_store.dart';

class CustomSlider extends StatelessWidget {
  CustomSlider({
    Key? key,
    required this.min,
    required this.max,
    required this.onDragging,
    required this.values,
    this.minimumDistance = 0,
    this.step,
  }) : super(key: key);
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final double min;
  final double max;
  final List<double> values;
  final FlutterSliderStep? step;
  final double minimumDistance;
  final Function(int handlerIndex, dynamic lowerValue, dynamic upperValue)
      onDragging;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
      child: FlutterSlider(
        minimumDistance: minimumDistance,
        selectByTap: false,
        step: step ?? FlutterSliderStep(),
        trackBar: FlutterSliderTrackBar(
          inactiveTrackBarHeight: 2,
          activeTrackBarHeight: 3,
          activeTrackBar: BoxDecoration(
            color: styleStore.primaryColor!.withAlpha(175),
          ),
          inactiveTrackBar: BoxDecoration(
            color: styleStore.textColor,
          ),
        ),
        handler: FlutterSliderHandler(
          decoration: BoxDecoration(),
          child: Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
                color: styleStore.primaryColor,
                borderRadius: BorderRadius.circular(16)),
          ),
        ),
        rightHandler: FlutterSliderHandler(
          decoration: BoxDecoration(),
          child: Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
                color: styleStore.primaryColor,
                borderRadius: BorderRadius.circular(16)),
          ),
        ),
        tooltip: FlutterSliderTooltip(
          custom: (a) {
            return Container(
              decoration: BoxDecoration(
                  color: styleStore.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: styleStore.primaryColor!)),
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              child: Text(
                a == max && a != 10
                    ? a.toInt().toString() + '+'
                    : a.toInt().toString(),
                style: GoogleFonts.getFont(
                  'Mitr',
                  color: styleStore.textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w100,
                ),
                textAlign: TextAlign.center,
              ),
            );
          },
          alwaysShowTooltip: true,
          disableAnimation: true,
          positionOffset: FlutterSliderTooltipPositionOffset(top: 20),
        ),
        values: values,
        rangeSlider: true,
        max: max,
        min: min,
        onDragging: onDragging,
      ),
    );
  }
}
