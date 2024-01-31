import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavItem extends StatelessWidget {
  final String imgUrl;
  final String title;
  final Function onTap;
  final bool isSelected;
  BottomNavItem({@required this.imgUrl, @required this.title, this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imgUrl, color: isSelected ? Theme.of(context).textTheme.bodyLarge.color : Colors.grey, height: 25, width: 25,
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
              Text(
                title.tr,
                style: robotoMedium.copyWith(
                  color: isSelected ? Theme.of(context).textTheme.bodyLarge.color : Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
