
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceDetailsTitle extends StatelessWidget {
  final String title;
  final String price;
  final TextStyle textStyle;


  PriceDetailsTitle({@required this.title, @required this.price, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title.tr,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: textStyle != null ? textStyle : robotoMedium.copyWith(
              color: Theme.of(context).textTheme.bodyLarge.color,
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
            ),
          ),
        ),
        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
        Flexible(
          child: Text(
           price,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: textStyle != null ? textStyle :robotoBold.copyWith(
              color: Theme.of(context).textTheme.bodyLarge.color,
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
            ),
          ),
        ),
      ],
    );
  }
}
