
import 'package:efood_multivendor_driver/data/api/api_client.dart';
import 'package:efood_multivendor_driver/data/model/body/pick_order_map_body.dart';
import 'package:efood_multivendor_driver/data/model/body/update_status_body.dart';
import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/body/laundry_place_order_body.dart';

class OrderRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  OrderRepo({@required this.apiClient, @required this.sharedPreferences});

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  Future<Response> getOrderList(int offset) async {
    return await apiClient.getData('${AppConstants.ORDER_URI}?limit=10&offset=$offset&token=${getUserToken()}');
  }

  Future<Response> getOrdersDetails(int orderId) async {
    return await apiClient.getData('${AppConstants.ORDER_DETAILS}?order_id=$orderId&token=${getUserToken()}');
  }

  Future<Response> updateOrderStatus(UpdateStatusBody updateStatusBody) async {
    return await apiClient.putData(AppConstants.ORDER_STATUS_UPDATE, updateStatusBody.toJson());
  }

  Future<Response> updateOrder(LaundryPlaceOrderBody orderBody) async {
    return await apiClient.putData('${AppConstants.LAUNDRY_ORDER_UPDATE}', orderBody.toJson());
  }

  Future<Response> getALlRoutes() async {
    return await apiClient.getData('${AppConstants.All_ROUTES}?token=${getUserToken()}');
  }

  Future<Response> getPickOrderRoute(PickOrderMapBody pickOrderMapBody) async {
    return await apiClient.postData(AppConstants.PICK_ORDER_ROUTE, pickOrderMapBody.toJson());
  }

  Future<Response> uploadPicture(Map<String, String> fields, List<MultipartBody> multiParts) async {
    return apiClient.postMultipartData(AppConstants.UPLOAD_PICTURE, fields, multiParts);
  }

  Future<Response> getAddressFromGeocode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.GEOCODE_URI}?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  Future<Response> getOrderHistoryList(String type, int offset) async {
    return await apiClient.getData('${AppConstants.LAUNDRY_ORDER_HISTORY}$type?limit=10&offset=$offset&token=${getUserToken()}');
  }






}