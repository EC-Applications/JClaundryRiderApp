import 'dart:convert';

import 'package:efood_multivendor_driver/controller/auth_controller.dart';
import 'package:efood_multivendor_driver/controller/laundry_cart_controller.dart';
import 'package:efood_multivendor_driver/controller/laundry_notification_controller.dart';
import 'package:efood_multivendor_driver/controller/laundry_service_controller.dart';
import 'package:efood_multivendor_driver/controller/laundry_service_list_controller.dart';
import 'package:efood_multivendor_driver/controller/profile_controller.dart';
import 'package:efood_multivendor_driver/controller/language_controller.dart';
import 'package:efood_multivendor_driver/controller/localization_controller.dart';
import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/controller/rider_wallet_controller.dart';
import 'package:efood_multivendor_driver/controller/splash_controller.dart';
import 'package:efood_multivendor_driver/controller/theme_controller.dart';
import 'package:efood_multivendor_driver/data/repository/auth_repo.dart';
import 'package:efood_multivendor_driver/data/repository/language_repo.dart';
import 'package:efood_multivendor_driver/data/repository/laundry_notification_repo.dart';
import 'package:efood_multivendor_driver/data/repository/laundry_service_list_repo.dart';
import 'package:efood_multivendor_driver/data/repository/laundry_service_repo.dart';
import 'package:efood_multivendor_driver/data/repository/order_repo.dart';
import 'package:efood_multivendor_driver/data/repository/profile_repo.dart';
import 'package:efood_multivendor_driver/data/repository/rider_repo.dart';
import 'package:efood_multivendor_driver/data/repository/splash_repo.dart';
import 'package:efood_multivendor_driver/data/api/api_client.dart';
import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:efood_multivendor_driver/data/model/response/language_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => LaundryServiceRepo(apiClient: Get.find()));
  Get.lazyPut(() => LaundryServiceListRepo(apiClient: Get.find()));
  Get.lazyPut(() => LaundryNotificationRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => RiderRepo(apiClient: Get.find(),sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => ProfileController(profileRepo: Get.find()));
  Get.lazyPut(() => LaundryCartController());
  Get.lazyPut(() => LaundryServiceController(laundryServiceRepo: Get.find()));
  Get.lazyPut(() => LaundryServiceListController(laundryServiceListRepo: Get.find()));
  Get.lazyPut(() => LaundryNotificationController(notificationRepo: Get.find()));
  Get.lazyPut(() => RiderWalletController(riderRepo: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
  }
  return _languages;
}
