import 'package:dotted_line/dotted_line.dart';
import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleDateView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {

      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
          border: Border.all(color: Theme.of(context).disabledColor.withOpacity(.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_DEFAULT),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(Images.calender, height: 40, width: 40,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'schedule_date'.tr,
                              style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).textTheme.bodyLarge.color),
                              maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                      Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                'select_pickup_time',
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_SMALL,
                                    color: Theme.of(context).textTheme.bodyLarge.color,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 3,),
                                Text(
                                  'select_pickup_date',
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                    color: Theme.of(context).textTheme.bodyLarge.color,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),


                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Theme.of(context).primaryColor, width: 1.5)
                            ),
                          ),

                          DottedLine(
                            lineLength: 60,
                            dashGapLength: 2,
                            dashLength: 3,
                            dashColor: Theme.of(context).disabledColor,
                          ),

                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle
                            ),
                          ),


                          SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'select_delivery_time',
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_SMALL,
                                    color: Theme.of(context).textTheme.bodyLarge.color,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 3,),
                                Text(
                                 'select_delivery_date',
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                    color: Theme.of(context).textTheme.bodyLarge.color,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),




                        ],
                      )
                    ],
                  ),
                ),
              ),
              // Spacer(),

            ],
          ),
        ),
      );
    });
  }
}
