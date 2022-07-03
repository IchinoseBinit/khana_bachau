import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/utils/size_config.dart';

class CurvedBodyWidget extends StatelessWidget {
  const CurvedBodyWidget({required this.widget, Key? key}) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: SizeConfig.height * 100,
        width: SizeConfig.width * 100,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
          color: Color(0xffEBEEF2),
        ),
        padding: basePadding,
        child: widget);
  }
}
