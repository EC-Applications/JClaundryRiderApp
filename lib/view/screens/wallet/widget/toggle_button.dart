import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleButton extends StatelessWidget {
  final String title;
  final bool isButtonActive;
  final Function onTap;

  ToggleButton({@required this.title, @required this.onTap, this.isButtonActive});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            //Icon(icon, size: 25),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
            Expanded(
              child: Text(
                isButtonActive != null ? (isButtonActive ? 'Active' : 'Inactive') : title ?? '',
                style: robotoRegular ?? TextStyle(),
              ),
            ),
            isButtonActive != null
                ? Switch(
                    value: isButtonActive,
                    onChanged: (bool isActive) {
                      if (onTap != null) {
                        onTap();
                      }
                    },
                    activeColor: Theme.of(context).primaryColor ?? Colors.blue,
                    activeTrackColor: Theme.of(context).primaryColor?.withOpacity(0.5) ?? Colors.blue.withOpacity(0.5),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
