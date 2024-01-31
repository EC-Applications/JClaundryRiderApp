import 'package:dotted_line/dotted_line.dart';
import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/laundry_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressViewLaundry extends StatelessWidget {
  final bool fromOrderDetails;


  AddressViewLaundry({this.fromOrderDetails = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (laundryLocationController) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_DEFAULT),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            border: Border.all(color: Theme.of(context).disabledColor.withOpacity(.4))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(fromOrderDetails) Row(
              children: [
                Image.asset(Images.map_laundry, height: 24, width: 24,),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                LaundryTitleWidget(titleName: 'address_delivery'),
              ],
            ),
            if(fromOrderDetails) SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Column(
                  children: [
                    Image.asset(Images.start, height: 16, width: 16,),
                    DottedLine(direction: Axis.vertical, lineLength: 60, dashColor: Theme.of(context).disabledColor.withOpacity(.8), lineThickness: 2),
                    Image.asset(Images.delivery_location_laundry, height: 24, width: 22, fit: BoxFit.cover,),
                  ],
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      InkWell(
                        onTap: () {

                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                              child: LaundryTitleWidget(titleName: 'pickup_address', fontSize: Dimensions.FONT_SIZE_DEFAULT,),
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                            Padding(
                              padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                              child: Text(
                                'pick up address',
                                style: robotoMedium.copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: Dimensions.FONT_SIZE_SMALL,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),


                      // Padding(
                      //   padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                      //   child: LaundryTitleWidget(titleName: 'pickup_address', fontSize: Dimensions.fontSizeDefault,),
                      // ),
                      // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                      //   child: Text(
                      //     laundryLocationController.pickUpAddress.isNotEmpty ? laundryLocationController.pickUpAddress : Get.find<LocationController>().getUserAddress().address,
                      //     style: robotoMedium.copyWith(
                      //       color: Theme.of(context).disabledColor,
                      //       fontSize: Dimensions.fontSizeSmall,
                      //     ),
                      //     maxLines: 2,
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),

                      Padding(
                        padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Divider(),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                      InkWell(
                        onTap: () {

                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                              child: LaundryTitleWidget(titleName: 'delivery_address', fontSize: Dimensions.FONT_SIZE_DEFAULT,),
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                            Padding(
                              padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                              child: Text(
                                'delivery address',
                                style: robotoMedium.copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: Dimensions.FONT_SIZE_SMALL,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                          ],
                        ),
                      )

                      // Padding(
                      //   padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                      //   child: LaundryTitleWidget(titleName: 'delivery_address', fontSize: Dimensions.fontSizeDefault,),
                      // ),
                      // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                      //   child: Text(
                      //     laundryLocationController.deliveryAddress.isNotEmpty ? laundryLocationController.deliveryAddress : 'set_address'.tr,
                      //     style: robotoMedium.copyWith(
                      //       color: Theme.of(context).disabledColor,
                      //       fontSize: Dimensions.fontSizeSmall,
                      //     ),
                      //     maxLines: 2,
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // ),

                    ],
                  ),
                ),



              ],
            ),
          ],
        ),
      );
    });
  }
}
