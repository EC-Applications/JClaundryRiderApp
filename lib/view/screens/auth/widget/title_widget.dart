import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  TitleWidget({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.tr,
      style: robotoBold.copyWith(
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          color: Theme.of(context).textTheme.bodyLarge.color
      ),
    );
  }
}
