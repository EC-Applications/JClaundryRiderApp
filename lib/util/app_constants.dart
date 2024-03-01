import 'package:efood_multivendor_driver/data/model/response/language_model.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static const String APP_NAME = 'JabChaho Delivery';
  static const double APP_VERSION = 5.2;

  //static const String BASE_URL = 'https://portal.apps-demo.com';
 static const String BASE_URL = 'http://175.107.222.99:403/';

  static const String CONFIG_URI = '/api/v1/config';
  static const String FORGET_PASSWORD_URI = '/api/v1/auth/delivery-man/forgot-password';
  static const String VERIFY_TOKEN_URI = '/api/v1/auth/delivery-man/verify-token';
  static const String RESET_PASSWORD_URI = '/api/v1/auth/delivery-man/reset-password';
  static const String LOGIN_URI = '/api/auth/laundry/delivery-man/login';
  static const String TOKEN_URI = '/api/v1/delivery-man/update-fcm-token';
  static const String CURRENT_ORDERS_URI = '/api/v1/delivery-man/current-orders?token=';
  static const String ORDER_URI = '/api/delivery-man/laundry/order/running-orders-list';
  static const String LATEST_ORDERS_URI = '/api/v1/delivery-man/latest-orders?token=';
  static const String RECORD_LOCATION_URI = '/api/v1/delivery-man/record-location-data';
  static const String PROFILE_URI = '/api/v1/delivery-man/profile?token=';
  static const String PROFILE_ORDER_STATUS = '/api/delivery-man/laundry/profile?token=';
  static const String UPDATE_ORDER_STATUS_URI = '/api/v1/delivery-man/update-order-status';
  static const String UPDATE_PAYMENT_STATUS_URI = '/api/v1/delivery-man/update-payment-status';
  static const String ORDER_DETAILS_URI = '/api/v1/delivery-man/order-details?token=';
  static const String ACCEPT_ORDER_URI = '/api/v1/delivery-man/accept-order';
  static const String REJECT_ORDER_URI = '/api/v1/delivery-man/reject-order';
  static const String ACTIVE_STATUS_URI = '/api/v1/delivery-man/update-active-status';
  static const String UPDATE_PROFILE_URI = '/api/delivery-man/laundry/update-profile?token=';
  static const String UPLOAD_PICTURE = '/api/delivery-man/laundry/order/save-picture';
  static const String NOTIFICATION_URI = '/api/delivery-man/laundry/get-notifications?token=';
  static const String SHIFT_LIST_URI = '/api/v1/delivery-man/get-shifts?token=';
  static const String STORE_SHIFT_URI = '/api/v1/delivery-man/store-time-log?token=';
  static const String ZONE_URI = '/api/v1/config/get-zone-id';
  static const String DOCUMENTS_URI = '/api/v1/delivery-man/documents?token=';
  static const String ORDER_STATUS_UPDATE = '/api/delivery-man/laundry/order/update-order-status';
  static const String ORDER_DETAILS = '/api/delivery-man/laundry/order/details';
  static const String LAUNDRY_SERVICE = '/api/services/list';
  static const String LAUNDRY_SERVICE_ITEM = '/api/laundry-item/list';
  static const String LAUNDRY_ORDER_UPDATE = '/api/delivery-man/laundry/order/update-order';
  static const String All_ROUTES = '/api/delivery-man/laundry/get-routes';
  static const String PICK_ORDER_ROUTE = '/api/laundry-config/get-routes';
  static const String GEOCODE_URI = '/api/v1/config/geocode-api';
  static const String NOTIFICATION_COUNT = 'iselect_notification_count';
  static const String LAUNDRY_NOTIFICATION_COUNT = 'laundry_iselect_notification_count';
  static const String LAUNDRY_NOTIFICATION_URI = '/api/delivery-man/laundry/get-notifications?token=';
  static const String LAUNDRY_ORDER_HISTORY = '/api/delivery-man/laundry/order/orders-history-list/';


  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'efood_multivendor_driver_token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String USER_COUNTRY_CODE = 'user_country_code';
  static const String NOTIFICATION = 'notification';
  static const String IGNORE_LIST = 'ignore_list';
  static const String TOPIC = 'all_zone_delivery_man';
  static const String ZONE_TOPIC = 'zone_topic';
  static const String LOCALIZATION_KEY = 'X-localization';
  static const String DELIVERY_SHIFT = 'delivery_shift';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.english, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.arabic, languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
  ];

  //order type
  static const String EXPRESS_SERVICE = 'Express Service';
  static const String APPOINTMENT = 'Appointment';
  static const String NORMAL = 'Normal';
  static const String REWORK = 'Rework';

  //order status
  static const String PENDING = 'pending';
  static const String CONFIRMED = 'confirmed';
  static const String OUT_FOR_PICKUP = 'out_for_pickup';
  static const String PICKED_UP = 'picked_up';
  static const String PROCESSING = 'processing';
  static const String ARRIVED = 'arrived';
  static const String READY_FOR_DELIVERY = 'ready_for_delivery';
  static const String OUT_FOR_DELIVERY = 'out_for_delivery';
  static const String DELIVERED = 'delivered';
  static const String CANCELED = 'cancelled';
  static const String DEFERRED = 'deferred';
  static const String RETURNED = 'returned';

  //Filter value
  static const String all = 'all';
  static const String pickedUp = 'picked_up';
  static const String delivered = 'delivered';

  static Color Earningscardcolor = Colors.orange;
  static Color handcahscardcolor = Colors.green;
}
