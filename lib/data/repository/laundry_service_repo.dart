
import 'package:efood_multivendor_driver/data/api/api_client.dart';
import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class LaundryServiceRepo {
  final ApiClient apiClient;
  LaundryServiceRepo({@required this.apiClient});

  Future<Response> getServiceList() async {
    return await apiClient.getData('${AppConstants.LAUNDRY_SERVICE}?limit=200&offset=1');
  }

}