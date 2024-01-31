import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTabBar extends StatelessWidget {
  final String title;
  final String count;
  final Function onTap;
  final bool isSelected;
  final bool isCountVisible;

  CustomTabBar({@required this.title, this.count, this.onTap, this.isSelected, this.isCountVisible = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * .43,
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).cardColor : null,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: isCountVisible ? MainAxisAlignment.end : MainAxisAlignment.center,
          children: [

            Text(
              title.tr,
              style: robotoMedium.copyWith(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  color: Theme.of(context).textTheme.bodyLarge.color
              ),
            ),
            if(isCountVisible) SizedBox(width: Dimensions.PADDING_SIZE_LARGE,),

            if(isCountVisible) Container(
              padding: count.length > 1 ? EdgeInsets.all(4) : EdgeInsets.all(8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                count.tr,
                style: robotoMedium.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge.color,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
