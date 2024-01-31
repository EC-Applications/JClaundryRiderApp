import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuspensionDialog extends StatelessWidget {
  final String description;
  const SuspensionDialog({@required this.description});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Image.asset(Images.suspended_vector, width: 50, height: 50),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
            child: Text(
              'you_are_suspended'.tr, textAlign: TextAlign.center,
              style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Colors.red),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text(description, style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE), textAlign: TextAlign.center),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          CustomButton(
            buttonText: 'ok'.tr,
            onPressed: () => Get.back(),
            height: 40,
          ),

        ]),
      ),
    );
  }
}
