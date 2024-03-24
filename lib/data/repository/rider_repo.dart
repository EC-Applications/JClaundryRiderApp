import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/app_constants.dart';
import '../api/api_client.dart';

class RiderRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  RiderRepo({this.apiClient , this.sharedPreferences});
 Future<Response> getWalletDetails() async {
  debugPrint("URI ${AppConstants.RIDER_WALLET_URI}${sharedPreferences.getString(AppConstants.TOKEN)}");
    return await apiClient.getData(AppConstants.RIDER_WALLET_URI + getUserToken());
  }
String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }
}