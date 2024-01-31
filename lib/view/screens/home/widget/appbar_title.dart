import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppbarTitle extends StatelessWidget {
  final String title;
  final String count;
  final Function onTap;


  AppbarTitle({@required this.title, @required this.count, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.tr,
            style: robotoRegular.copyWith(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: Theme.of(context).disabledColor
            ),
          ),
          SizedBox(
            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          ),
          Text(
            count.tr,
            style: robotoBold.copyWith(
              fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
              color: Theme.of(context).textTheme.bodyLarge.color,
            ),
          ),
        ],
      ),
    );
  }
}
