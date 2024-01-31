import 'package:efood_multivendor_driver/controller/auth_controller.dart';
import 'package:efood_multivendor_driver/helper/date_converter.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_driver/view/base/custom_button.dart';
import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShiftScreen extends StatefulWidget {
  const ShiftScreen({Key key}) : super(key: key);

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {

  @override
  void initState() {
    super.initState();

    Get.find<AuthController>().getShifts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'shifts'.tr, isBackButtonExist: false),
      body: GetBuilder<AuthController>(builder: (authController) {
        return Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [

            Text(
              'select_your_delivery_shift'.tr,
              style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

            Expanded(child: (authController.shiftList != null && !authController.isLoading) ? authController.shiftList.isNotEmpty ? ListView.builder(
              itemCount: authController.shiftList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => authController.setShiftIndex(index),
                  child: Container(
                    margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      border: Border.all(
                        color: authController.shiftIndex == index ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.bodyLarge.color,
                        width: authController.shiftIndex == index ? 2 : 1,
                      ),
                    ),
                    child: Row(children: [

                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                        Text(
                          authController.shiftList[index].title + (authController.shiftList[index].isSpecial == 1 ? ' (${'special'.tr})' : ''),
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

                      ])),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                      index == authController.shiftIndex ? Icon(
                        Icons.check_circle, color: Theme.of(context).primaryColor,
                      ) : SizedBox(),

                    ]),
                  ),
                );
              },
            ) : Center(child: Text('no_shift_available'.tr)) : Center(child: CircularProgressIndicator())),

            Row(children: [

              Expanded(child: CustomButton(
                buttonText: 'save_and_go_online'.tr,
                onPressed: () {
                  _saveShift(authController, true);
                },
              )),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

              Expanded(child: CustomButton(
                buttonText: 'save'.tr,
                onPressed: () {
                  _saveShift(authController, false);
                },
              )),

            ]),

          ]),
        );
      }),
    );
  }

  void _saveShift(AuthController authController, bool makeOnline) {
    if(authController.shiftIndex == -1) {
      showCustomSnackBar('select_your_delivery_shift'.tr);
    }else if(authController.profileModel.active == 1) {
      showCustomSnackBar('you_are_already_in_a_shift'.tr);
    }else {
      DateTime _startTime = DateConverter.stringTimeToDate(authController.shiftList[authController.shiftIndex].startTime);
      DateTime _endTime = DateConverter.stringTimeToDate(authController.shiftList[authController.shiftIndex].endTime);
      DateTime _now = DateTime.now();
      _startTime = DateTime(_now.year, _now.month, _now.day, _startTime.hour, _startTime.minute);
      _endTime = DateTime(_now.year, _now.month, _now.day, _endTime.hour, _endTime.minute);
      if(_now.isAfter(_endTime)) {
        showCustomSnackBar('you_can_not_pick_past_time_shift'.tr);
      }else if(makeOnline && _now.isBefore(_startTime)) {
        showCustomSnackBar('shift_is_not_started_yet'.tr);
      }else {
        authController.storeShifts(authController.shiftList[authController.shiftIndex], _now.isBefore(_startTime));
        // authController.updateActiveStatus();
      }
    }
  }

}
