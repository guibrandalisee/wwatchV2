import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:wwatch/Shared/Themes/app_colors.dart';
import 'package:wwatch/stores/style_store.dart';

class BackToTopButton extends StatefulWidget {
  const BackToTopButton({Key? key, this.scrollController}) : super(key: key);

  @override
  _BackToTopButtonState createState() => _BackToTopButtonState();
  final scrollController;
}

class _BackToTopButtonState extends State<BackToTopButton>
    with SingleTickerProviderStateMixin {
  final StyleStore styleStore = GetIt.I<StyleStore>();
  late AnimationController controller;
  late Animation<double> buttonAnimation;
  bool visible = false;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    buttonAnimation = Tween<double>(begin: 0, end: 38).animate(controller);

    widget.scrollController.addListener(scrollChanged);
  }

  void scrollChanged() {
    final s = widget.scrollController.position;

    if (s.userScrollDirection == ScrollDirection.reverse) {
      if (visible) {
        visible = false;
        controller.reverse();
      }
    } else if (s.pixels > 1000) {
      if (!visible) {
        visible = true;
        controller.forward();
      }
    }
    if (s.pixels < 1000 && visible) {
      visible = false;
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: buttonAnimation,
        builder: (context, __) {
          return Container(
            height: 38,
            width: 38,
            child: GestureDetector(
              onTap: Feedback.wrapForTap(() async {
                if (visible) {
                  await widget.scrollController.animateTo(120.0,
                      duration: Duration(seconds: 1), curve: Curves.ease);
                }
              }, context),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: styleStore.primaryColor,
                      borderRadius: BorderRadius.circular(42)),
                  height: buttonAnimation.value,
                  width: buttonAnimation.value,
                  child: Center(
                      child: Visibility(
                    visible: visible,
                    child: Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: buttonAnimation.value / 1.5,
                      color: AppColors.textOnPrimaries[styleStore.colorIndex!],
                    ),
                  )),
                ),
              ),
            ),
          );
        });
  }
}
