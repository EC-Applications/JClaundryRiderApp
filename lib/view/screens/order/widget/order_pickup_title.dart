import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPickupTitle extends StatelessWidget {
  final String title;

  OrderPickupTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.tr,
      style: robotoMedium.copyWith(
        fontSize: Dimensions.FONT_SIZE_LARGE,
        color: Theme.of(context).disabledColor,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
