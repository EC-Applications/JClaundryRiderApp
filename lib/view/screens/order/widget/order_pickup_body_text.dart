import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPickupBodyText extends StatelessWidget {
  final String bodyText;

  OrderPickupBodyText({@required this.bodyText});

  @override
  Widget build(BuildContext context) {
    return Text(
      bodyText.tr,
      style: robotoRegular.copyWith(
        fontSize: Dimensions.FONT_SIZE_LARGE,
        color: Theme.of(context).textTheme.bodyLarge.color,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
