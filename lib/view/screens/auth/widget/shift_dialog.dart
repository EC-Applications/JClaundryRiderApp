import 'package:efood_multivendor_driver/controller/auth_controller.dart';
import 'package:efood_multivendor_driver/helper/date_converter.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShiftDialog extends StatelessWidget {
  const ShiftDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(Get.find<AuthController>().shiftList == null) {
      Get.find<AuthController>().getShifts();
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      child: GetBuilder<AuthController>(builder: (authController) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [

            Text(
              'select_your_delivery_shift'.tr,
              style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

            (authController.shiftList != null && !authController.isLoading) ? authController.shiftList.isNotEmpty ? ListView.builder(
              itemCount: authController.shiftList.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    DateTime _startTime = DateConverter.stringTimeToDate(authController.shiftList[index].startTime);
                    DateTime _endTime = DateConverter.stringTimeToDate(authController.shiftList[index].endTime);
                    DateTime _now = DateTime.now();
                    _startTime = DateTime(_now.year, _now.month, _now.day, _startTime.hour, _startTime.minute);
                    _endTime = DateTime(_now.year, _now.month, _now.day, _endTime.hour, _endTime.minute);
                    if(_now.isAfter(_endTime)) {
                      showCustomSnackBar('you_can_not_pick_past_time_shift'.tr);
                    }else {
                      authController.storeShifts(authController.shiftList[index], _now.isBefore(_startTime));
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      border: Border.all(color: Theme.of(context).textTheme.bodyLarge.color),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                      Text(
                        authController.shiftList[index].title,
                        style: robotoRegular, maxLines: 1, overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                      Row(children: [

                        Text(
                          '${'shift_time'.tr}:',
                          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                        Text(
                          '${DateConverter.isoStringToTime(authController.shiftList[index].startTime)} '
                              '- ${DateConverter.isoStringToTime(authController.shiftList[index].endTime)}',
                          style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),

                      ]),

                    ]),
                  ),
                );
              },
            ) : Center(child: Text('no_shift_available'.tr)) : Center(child: CircularProgressIndicator()),

          ]),
        );
      }),
    );
  }
}
