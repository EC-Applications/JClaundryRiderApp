
import 'package:efood_multivendor_driver/data/api/api_client.dart';
import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaundryNotificationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LaundryNotificationRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getNotificationList(int offset) async {
    return await apiClient.getData('${AppConstants.LAUNDRY_NOTIFICATION_URI}${getUserToken()}&offset=$offset&limit=10');
  }

  void saveSeenNotificationCount(int count) {
    sharedPreferences.setInt(AppConstants.LAUNDRY_NOTIFICATION_COUNT, count);
  }

  int getSeenNotificationCount() {
    return sharedPreferences.getInt(AppConstants.LAUNDRY_NOTIFICATION_COUNT);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

}