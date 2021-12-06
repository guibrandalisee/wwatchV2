import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/style_store.dart';

class DropDownButtonWidget extends StatefulWidget {
  DropDownButtonWidget({
    required this.items,
    required this.value,
    required this.onChanged,
  });
  final List<String> items;
  final String value;
  final void Function(String?) onChanged;
  @override
  _DropDownButtonWidgetState createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  final StyleStore styleStore = GetIt.I<StyleStore>();
  @override
  Widget build(BuildContext context) {
    String value = widget.value;

    return Container(
      decoration: BoxDecoration(
          color: styleStore.dropdownColor,
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: 340,
      child: SizedBox(
        width: 340,
        child: DropdownButton<String>(
            dropdownColor: styleStore.backgroundColor,
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColors.text,
            ),
            isExpanded: true,
            style: GoogleFonts.getFont('Mitr',
                color: AppColors.text,
                fontSize: 18,
                fontWeight: FontWeight.w300),
            underline: Container(),
            value: value,
            onChanged: widget.onChanged,
            iconSize: 24,
            elevation: 16,
            items: widget.items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()),
      ),
    );
  }
}
