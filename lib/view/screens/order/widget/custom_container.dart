import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final bool isArrowDownIconShow;
  final Function onTap;
  CustomContainer({@required this.text, this.isArrowDownIconShow = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).disabledColor.withOpacity(.5),),
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: robotoRegular.copyWith(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: Theme.of(context).textTheme.bodyLarge.color,
              ),
            ),

            isArrowDownIconShow ? Padding(
              padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
              child: Image.asset(Images.arrow_down, height: 8, width: 14, color: Theme.of(context).primaryColor, ),
            ) : SizedBox()
          ],
        ),
      ),
    );
  }
}
