
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaundryTitleWidget extends StatelessWidget {
  final String titleName;
  final double fontSize;

  LaundryTitleWidget({@required this.titleName, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(titleName.tr, style: robotoBold.copyWith(fontSize: fontSize != null ? fontSize : Dimensions.FONT_SIZE_EXTRA_LARGE, color: Theme.of(context).textTheme.bodyLarge.color),);
  }
}
