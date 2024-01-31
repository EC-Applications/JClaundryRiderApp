import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  final bool isFilterButtonExist;
  final Function onBackPressed;
  final Function onFilterPressed;
  CustomAppBar({@required this.title, this.isBackButtonExist = true, this.onBackPressed, this.isFilterButtonExist = false, this.onFilterPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Theme.of(context).textTheme.bodyLarge.color)),
      centerTitle: true,
      leading: isBackButtonExist ? InkWell(
        onTap: () => onBackPressed != null ? onBackPressed() : Navigator.pop(context),
        child: Container(
          alignment: Alignment.center,
          child: Image.asset(
            Images.arrow_left, height: 18, width: 18,
            color: Theme.of(context).textTheme.bodyLarge.color,
          ),
        ),
      ) : SizedBox(),
      backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
      actions: [
        isFilterButtonExist ? InkWell(
          onTap: onFilterPressed,
          child: Padding(
            padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT),
            child: Image.asset(
              Images.filter, height: 24, width: 24,
              color: Theme.of(context).textTheme.bodyLarge.color,
            ),
          ),
        ) : SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}
