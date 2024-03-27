import 'package:dotted_line/dotted_line.dart';
import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/data/model/response/order_list_model.dart';
import 'package:efood_multivendor_driver/helper/date_converter.dart';
import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderItemView extends StatelessWidget {
  final OrderList orderList;
  final Function onTap;
  final bool isHistory;

  OrderItemView({@required this.orderList, this.onTap, this.isHistory = false });

  @override
  Widget build(BuildContext context) {

    return GetBuilder<OrderController>(builder: (orderController) {
      return InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
              border: Border.all(color: Theme.of(context).disabledColor.withOpacity(.5))
          ),
          child: Stack(
          children: [
         orderList.orderStatus == "deferred" ?    Positioned(
              left: 290,
              right: 3,
              child: Container(
              height: 33,
              width: 33,
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Center(child: Text(orderList.deferredAt == "out_for_delivery" ? "D" : "",
              style:  TextStyle(
                color: Colors.white,
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
              ),
              ),),
            )) : SizedBox(),
          Column(
              children: [
          
                Row(
                  children: [
          
                    Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor.withOpacity(.2),
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                      ),
                      child: Image.asset(
                        Images.package,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
          
                    Expanded(
                      child: Column(
                        children: [
          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  orderList.id.toString(),
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_LARGE,
                                    color: Theme.of(context).textTheme.bodyLarge.color,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Flexible(
                              //   child: Text(
                              //     'TTP',
                              //     style: robotoBold.copyWith(
                              //       fontSize: Dimensions.FONT_SIZE_LARGE,
                              //       color: Theme.of(context).textTheme.bodyLarge.color,
                              //     ),
                              //     maxLines: 1,
                              //     overflow: TextOverflow.ellipsis,
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                          Row(
          
                            children: [
                              Image.asset(
                                Images.mark, height: 15, width: 13,
                              ),
                              SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${orderController.getAddress(orderList.orderStatus, orderList)?.address ?? ''}',
                                        style: robotoRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_LARGE,
                                          color: Theme.of(context).disabledColor,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
          
                                    // Flexible(
                                    //   child: Text(
                                    //    isHistory ? '${orderList.orderStatus == AppConstants.PICKED_UP ? DateConverter.dateTimeStringToDateOnly(orderList.pickedUp) : orderList.orderStatus == AppConstants.DELIVERED ? DateConverter.dateTimeStringToDateOnly(orderList.delivered) :
                                    //    DateConverter.getRemainingTime(orderController.getScheduleTime(orderController.checkPickUpDeliveryStatus(orderList.orderStatus)
                                    //        ? true : false, orderList: orderList))}' : '${DateConverter.getRemainingTime(orderController.getScheduleTime(orderController.checkPickUpDeliveryStatus(orderList.orderStatus)
                                    //     ? true : false, orderList: orderList))}',
                                    //     style: robotoRegular.copyWith(
                                    //       fontSize: Dimensions.FONT_SIZE_LARGE,
                                    //       color: Theme.of(context).disabledColor,
                                    //     ),
                                    //     maxLines: 1,
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
                    ),
          
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          
                DottedLine(
                  direction: Axis.horizontal,
                  dashColor: Theme.of(context).disabledColor.withOpacity(.4),
                  dashGapLength: 2,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
          
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: orderList.laundryDeliveryType != null && orderList.laundryDeliveryType.id != 1 ? Colors.red : Colors.blue
                      ),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
          
                    Expanded(
                      child: RichText(text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${'type'.tr}:',
                              style: robotoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                            WidgetSpan(child: SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,)),
          
                            TextSpan(
                              text: '${orderList.laundryDeliveryType.title != null ? orderList.laundryDeliveryType.title : ''}',
                              style: robotoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                color:orderList.laundryDeliveryType != null && orderList.laundryDeliveryType.id != 1 ? Colors.red : Colors.blue,
                              ),
                            ),
                          ]
                      ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
          
                    Spacer(),
          
          
                    Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      ),
                      child: Icon(Icons.keyboard_arrow_right_rounded, size: 16, color: Theme.of(context).cardColor,),
                    ),
                  ],
                ),
              ],
            ),
          
          ],
          )
        ),
      );
    });
  }
}
