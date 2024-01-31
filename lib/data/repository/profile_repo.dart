import 'package:efood_multivendor_driver/data/api/api_client.dart';
import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ProfileRepo({@required this.apiClient, @required this.sharedPreferences});

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }
  Future<Response> getProfileOrderStatus() async {
    return await apiClient.getData(AppConstants.PROFILE_ORDER_STATUS + getUserToken());
  }
}