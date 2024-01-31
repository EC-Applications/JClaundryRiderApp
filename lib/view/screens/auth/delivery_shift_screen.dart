import 'package:efood_multivendor_driver/controller/auth_controller.dart';
import 'package:efood_multivendor_driver/helper/date_converter.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryShiftScreen extends StatefulWidget {
  const DeliveryShiftScreen({Key key}) : super(key: key);

  @override
  State<DeliveryShiftScreen> createState() => _DeliveryShiftScreenState();
}

class _DeliveryShiftScreenState extends State<DeliveryShiftScreen> {

  @override
  void initState() {
    super.initState();

    Get.find<AuthController>().getShifts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AuthController>(builder: (authController) {
          return Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Text(
                'select_your_delivery_shift'.tr,
                style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              authController.shiftList != null ? authController.shiftList.isNotEmpty ? ListView.builder(
                itemCount: authController.shiftList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {

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
      ),
    );
  }
}
