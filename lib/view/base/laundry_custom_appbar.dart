
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaundryCustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final Function onTap;
  final String leadingImgUrl;
  final double imgHeight;
  final double imgWidth;
  final String actionImgUrl;
  final bool isActionIcon;
  final bool isBackButtonExist;


  LaundryCustomAppbar({
    this.title,
    this.onTap,
    this.leadingImgUrl = Images.arrow_left,
    this.imgHeight = 24,
    this.imgWidth = 24,
    this.actionImgUrl,
    this.isActionIcon = false,
    this.isBackButtonExist = true
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title.tr, style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Theme.of(context).textTheme.bodyLarge.color),),
      centerTitle: true,
      leading: isBackButtonExist ? InkWell(
        onTap: onTap != null ? onTap  : () => Navigator.pop(context),
        child: Container(
          alignment: Alignment.center,
          child: Image.asset(leadingImgUrl, height: imgHeight, width: imgWidth, color: Theme.of(context).textTheme.bodyLarge.color,),
        ),
      ) : null,
      actions: isActionIcon ? [
        Padding(
          padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
          child: Image.asset(actionImgUrl, height: 24, width: 24, color: Theme.of(context).textTheme.bodyLarge.color.withOpacity(.5),),
        ),
      ] : null,
      backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
