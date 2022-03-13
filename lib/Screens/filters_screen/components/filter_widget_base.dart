import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wwatch/stores/settings_store.dart';
import 'package:wwatch/stores/style_store.dart';

class FilterWidgetBase extends StatelessWidget {
  FilterWidgetBase({
    Key? key,
    required this.onChanged,
    required this.title,
    this.child,
    required this.value,
  }) : super(key: key);
  final Function(bool) onChanged;
  final String title;
  final StyleStore styleStore = GetIt.I<StyleStore>();
  final Widget? child;
  final SettingsStore settingsStore = GetIt.I<SettingsStore>();
  final bool value;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: styleStore.shapeColor,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 4),
              spreadRadius: 0)
        ],
        color: settingsStore.brightness == CustomBrightness.amoled
            ? styleStore.shapeColor
            : styleStore.backgroundColor!
                .withBlue(styleStore.backgroundColor!.blue - 2)
                .withGreen(styleStore.backgroundColor!.green - 2)
                .withRed(styleStore.backgroundColor!.red - 2),
      ),
      margin: EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 56,
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    title,
                    style: GoogleFonts.getFont(
                      'Mitr',
                      color: styleStore.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                height: 56,
                child: Center(
                  child: Switch(
                    value: value,
                    onChanged: onChanged,
                    activeColor: styleStore.primaryColor,
                  ),
                ),
              )
            ],
          ),
          child != null ? child! : Container()
        ],
      ),
    );
  }
}
