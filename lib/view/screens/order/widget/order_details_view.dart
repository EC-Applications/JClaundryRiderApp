import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/data/model/body/pick_order_map_body.dart';
import 'package:efood_multivendor_driver/data/model/response/laundry_order_details_model.dart';
import 'package:efood_multivendor_driver/data/model/response/order_list_model.dart';
import 'package:efood_multivendor_driver/helper/date_converter.dart';
import 'package:efood_multivendor_driver/helper/route_helper.dart';
import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/order_pickup_body_text.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/order_pickup_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderDetailsView extends StatelessWidget {
  final LaundryOrderDetails orderDetailsModel;
  OrderDetailsView({@required this.orderDetailsModel});


  @override
  Widget build(BuildContext context) {
    
    return GetBuilder<OrderController>(builder: (orderController) {
      return  orderController.isLoadingLocation ? Scaffold(body: Center(child: CircularProgressIndicator())) : orderController.laundryOrderDetailsModel != null ? Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            border: Border.all(color: Theme.of(context).disabledColor.withOpacity(.5))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                children: [

                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor.withOpacity(.5),
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
                                '${orderDetailsModel.id}',
                                style: robotoBold.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  color: Theme.of(context).textTheme.bodyLarge.color,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if(!orderController.isOrderPicked) Flexible(
                              child: Text(
                                'TTP',
                                style: robotoBold.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  color: Theme.of(context).textTheme.bodyLarge.color,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                        Row(

                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
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
                                            text: '${orderDetailsModel.laundryDeliveryType != null ? orderDetailsModel.laundryDeliveryType.title : ''}',
                                            style: robotoRegular.copyWith(
                                              fontSize: Dimensions.FONT_SIZE_LARGE,
                                              color: orderDetailsModel.laundryDeliveryType != null && orderDetailsModel.laundryDeliveryType.id != 1 ? Colors.red : Colors.blue,
                                            ),
                                          ),
                                        ]
                                    ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  if ( !orderController.isEdited) Flexible(
                                    child: Text(
                                      orderDetailsModel.orderStatus == AppConstants.PICKED_UP ? DateConverter.dateTimeStringToDateOnly(orderDetailsModel.pickedUp) : orderDetailsModel.orderStatus == AppConstants.DELIVERED ? DateConverter.dateTimeStringToDateOnly(orderDetailsModel.delivered) :
                                        '${DateConverter.getRemainingTime(orderController.getScheduleTime(orderController.checkPickUpDeliveryStatus(orderDetailsModel.orderStatus)
                                          ? true : false, orderDetailsModel: orderDetailsModel))}',
                                      style: robotoRegular.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_LARGE,
                                        color: Theme.of(context).disabledColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
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
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
            Padding(
              padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, bottom: Dimensions.PADDING_SIZE_SMALL),
              child: Text(
                '${'order_status'.tr}: ${orderController.removeUnderScore(orderDetailsModel.orderStatus)}',
                style: robotoBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                  color: Theme.of(context).disabledColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            orderController.isEdited ? SizedBox() : Divider(thickness: 1),

            orderController.isEdited ? SizedBox() : Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  OrderPickupTitle(
                    title: 'customer_name',
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                  OrderPickupBodyText(
                    bodyText: '${orderDetailsModel.destinationAddress?.contactPersonName ?? ''}',
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OrderPickupTitle(
                              title: orderController.checkPickUpDeliveryStatus(orderDetailsModel.orderStatus) ? 'pick_up_address' : 'delivery_address',
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                            OrderPickupBodyText(
                              bodyText: '${orderController.checkPickUpDeliveryStatus(orderDetailsModel.orderStatus)
                                  ? orderDetailsModel.pickupAddress?.address ?? '' : orderDetailsModel.destinationAddress?.address ?? ''}',
                            ),
                          ],
                        ),
                      ),

                     InkWell(
                        // onTap: () => Get.toNamed(RouteHelper.getPickUpRoute(), arguments: true),
                       onTap: () async{
                         await orderController.getCurrentLocation();
                         if(orderController.isLocationPermission) {
                           orderController.getAddressFromGeocode(LatLng(orderController.position.latitude, orderController.position.longitude));
                           await orderController.getPickOrderRoute(
                             PickOrderMapBody(
                               pickupCoordinates: [orderController.position.latitude, orderController.position.longitude],
                               destinationCoordinates: [
                                 orderController.checkPickUpDeliveryStatus(orderDetailsModel.orderStatus) ? orderController.laundryOrderDetailsModel.pickupCoordinates.coordinates[1] :
                                 orderController.laundryOrderDetailsModel.destinationCoordinates.coordinates[1],
                                 orderController.checkPickUpDeliveryStatus(orderDetailsModel.orderStatus) ? orderController.laundryOrderDetailsModel.pickupCoordinates.coordinates[0] :
                                 orderController.laundryOrderDetailsModel.destinationCoordinates.coordinates[0]
                               ],
                             ),
                             _callBack,
                             orderController.laundryOrderDetailsModel,
                           );

                           Get.toNamed(RouteHelper.getPickUpRoute(OrderList(id: orderDetailsModel.id)), arguments: true);
                         }



                       },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                              border: Border.all(
                                color: Theme.of(context).hintColor.withOpacity(.5),
                              )
                          ),
                          child: Image.asset(
                            Images.map, height: 24, width: 24, color: Theme.of(context).textTheme.bodyLarge.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                  OrderPickupTitle(
                    title: 'order_placed',
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                  OrderPickupBodyText(
                    bodyText: '${DateConverter.formatTimestamp(orderDetailsModel.createdAt)}',
                  ),

                ],
              ),
            ),
          ],
        ),
      ) : Center(child: CircularProgressIndicator(),);
    });
  }
  void _callBack(bool isSuccess, String message, String orderId, {bool showSnackBar = true, bool isError = false}) {
    if(isSuccess) {
      if (showSnackBar) {
        showCustomSnackBar(message, isError: isError);
      }


    }else {
      showCustomSnackBar(message, isError:  isError);
    }
  }
}
