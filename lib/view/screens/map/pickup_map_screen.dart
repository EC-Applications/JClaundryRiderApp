import 'package:dotted_line/dotted_line.dart';
import 'package:efood_multivendor_driver/controller/auth_controller.dart';
import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/data/model/body/update_status_body.dart';
import 'package:efood_multivendor_driver/data/model/response/order_list_model.dart';
import 'package:efood_multivendor_driver/helper/route_helper.dart';
import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/slider_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickUpMapScreen extends StatelessWidget {
  final OrderList orderList;
  final bool showLocationDetails;

  PickUpMapScreen({this.showLocationDetails = false, this.orderList});

  @override
  Widget build(BuildContext context) {
    print('order id: ${orderList.id}');
    return GetBuilder<OrderController>(builder: (orderController) {
      return orderController.isLoading ? Scaffold(body: Center(child: CircularProgressIndicator())) : Scaffold(
        appBar: CustomAppBar(
          title: showLocationDetails ? 'location_detail'.tr : 'pickup_in_progress'.tr,
        ),
        body: Container(
          child: Stack(children: [
            //map
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0), // Coordinates for Dhaka
                zoom: 17, // Zoom level
              ),
              minMaxZoomPreference: MinMaxZoomPreference(0, 100),
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              indoorViewEnabled: true,
              markers: orderController.markers,
              polylines: orderController.polyline,
              onMapCreated: (controller) {
                orderController.setMapController(controller);
                orderController.boundMap(controller, orderController.polyline.first.points.first, orderController.polyline.first.points.last, fromPickMap: true);
              },
            ),

            //swipe button
            if(!showLocationDetails) Positioned(
              bottom: 30,
              left: 15,
              right: 15,
              child: !orderController.isLoaded? SliderButton(

                label: Text(
                  'swipe_to_pickup'.tr,
                  style: robotoBold.copyWith(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    color: Theme.of(context).cardColor,
                  ),
                ),
                action: () async{
                  orderController.setLoading(true);
                  await orderController.updateOrderStatus(
                    UpdateStatusBody(
                      orderId: orderController.orderListModel.id.toString(),
                      status: AppConstants.OUT_FOR_PICKUP,
                      token: Get.find<AuthController>().getUserToken()
                    ),
                      _callBack,
                  );
                  orderController.setLoading(false);

                },
                icon: Icon(Icons.arrow_forward_ios_rounded, size: 24, color: Theme.of(context).cardColor,),
                dismissThresholds: 0.5, dismissible: false, shimmer: true,
                width: MediaQuery.of(context).size.width - 30, height: 60, buttonSize: 50, radius: 10,
                boxShadow: BoxShadow(blurRadius: 0),
                buttonColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).textTheme.bodyLarge.color,
                baseColor: Theme.of(context).primaryColor,


              ) : Center(child: CircularProgressIndicator()),
            ),

            //location details
            if(showLocationDetails) Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE, vertical: 40),
                alignment: Alignment.center,
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        Icon(Icons.radio_button_checked_rounded, size: 24, color: Theme.of(context).primaryColor,),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                        Expanded(
                          child: Text(
                            '${orderController.currentAddress != null ? orderController.currentAddress : 'loading'.tr}',
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
                    Padding(
                      padding: const EdgeInsets.only(left: 11),
                      child: DottedLine(
                        direction: Axis.vertical,
                        lineLength: 30,
                        lineThickness: 2,
                        dashLength: 6,
                        dashColor: Theme.of(context).disabledColor,
                      ),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),

                    Row(
                      children: [

                        Image.asset(Images.location_icon, height: 24, width: 24, color: Theme.of(context).textTheme.bodyLarge.color,),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                        Expanded(
                          child: Text(
                            '${orderController.checkPickUpDeliveryStatus(orderController.laundryOrderDetailsModel.orderStatus) ?
                            orderController.laundryOrderDetailsModel.pickupAddress.address : orderController.laundryOrderDetailsModel.destinationAddress.address }',
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
                  ],
                ),
              ),
            ),

          ]),
        ),
      );
    });
  }

  void _callBack(bool isSuccess, String message, String orderId) {
    if(isSuccess) {
      showCustomSnackBar(message, isError: false);
      Get.offNamed(RouteHelper.getOrderPickupDetailsRoute(orderList));

    }else {
      showCustomSnackBar(message, isError: true);
    }
  }
}
