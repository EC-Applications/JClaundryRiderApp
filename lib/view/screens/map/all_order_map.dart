
import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/view/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';


class AllOrderMap extends StatefulWidget {

  @override
  State<AllOrderMap> createState() => _AllOrderMapState();
}

class _AllOrderMapState extends State<AllOrderMap> {
  @override
  void initState() {
    Get.find<OrderController>().getAllRoutes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return GetBuilder<OrderController>(builder: (orderController) {

      return orderController.isLoading != null ? Scaffold(
        appBar: CustomAppBar(title: 'track_path'.tr),
        body: orderController.allOrderTrackList != null ? GoogleMap(
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
            orderController.boundMap(controller, orderController.polyline.first.points.first, orderController.polyline.first.points.last);
          },
        ) : Center(child: Text('no_data_found'.tr)),
      ) : Scaffold(body: Center(child: CircularProgressIndicator(),));
    });
  }


}
