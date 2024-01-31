
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/price_details_title.dart';
import 'package:flutter/material.dart';

class PriceViewLaundry extends StatelessWidget {
  final String subtotal;
  final String deliveryFee;
  final String total;

  PriceViewLaundry({@required this.subtotal, @required this.deliveryFee, @required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        PriceDetailsTitle(title: 'subtotal', price: subtotal),
        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

        PriceDetailsTitle(title: 'delivery_fee', price: deliveryFee),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

        Divider(
          thickness: 1,
          color: Theme.of(context).disabledColor.withOpacity(.3),
        ),

        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
        PriceDetailsTitle(
          title: 'total',
          price: total,
          textStyle: robotoBold.copyWith(
              color: Theme.of(context).textTheme.bodyLarge.color,
              fontSize: Dimensions.FONT_SIZE_LARGE
          ),
        ),

      ],
    );
  }
}
