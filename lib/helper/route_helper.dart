import 'dart:convert';

import 'package:efood_multivendor_driver/data/model/response/order_list_model.dart';
import 'package:efood_multivendor_driver/view/screens/auth/delivery_shift_screen.dart';
import 'package:efood_multivendor_driver/view/screens/auth/sign_in_screen.dart';
import 'package:efood_multivendor_driver/view/screens/dashboard/dashboard_screen.dart';
import 'package:efood_multivendor_driver/view/screens/forget/forget_pass_screen.dart';
import 'package:efood_multivendor_driver/view/screens/forget/new_pass_screen.dart';
import 'package:efood_multivendor_driver/view/screens/forget/verification_screen.dart';
import 'package:efood_multivendor_driver/view/screens/html/html_viewer_screen.dart';
import 'package:efood_multivendor_driver/view/screens/language/language_screen.dart';
import 'package:efood_multivendor_driver/view/screens/map/all_order_map.dart';
import 'package:efood_multivendor_driver/view/screens/map/pickup_map_screen.dart';
import 'package:efood_multivendor_driver/view/screens/notification/notification_screen_laundry.dart';
import 'package:efood_multivendor_driver/view/screens/order/add_item_screen.dart';
import 'package:efood_multivendor_driver/view/screens/order/order_details_screen.dart';
import 'package:efood_multivendor_driver/view/screens/order/order_pickup_details_screen.dart';
import 'package:efood_multivendor_driver/view/screens/order/order_screen.dart';
import 'package:efood_multivendor_driver/view/screens/order/running_order_screen.dart';
import 'package:efood_multivendor_driver/view/screens/profile/update_profile_screen.dart';
import 'package:efood_multivendor_driver/view/screens/splash/splash_screen.dart';
import 'package:efood_multivendor_driver/view/screens/support/support_screen.dart';
import 'package:efood_multivendor_driver/view/screens/update/update_screen.dart';
import 'package:get/get.dart';


class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String signIn = '/sign-in';
  static const String verification = '/verification';
  static const String main = '/main';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String order = '/order';
  static const String orderDetails = '/order-details';
  static const String orderPickupDetails = '/order-pickup-details';
  static const String updateProfile = '/update-profile';
  static const String notification = '/notification';
  static const String runningOrder = '/running-order';
  static const String terms = '/terms-and-condition';
  static const String privacy = '/privacy-policy';
  static const String language = '/language';
  static const String update = '/update';
  static const String shift = '/shift';
  static const String addItem = '/add-item';
  static const String pickup = '/pickup';
  static const String support = '/help-and-support';
  static const String trackPath = '/track-path';
  static const String laundryNotification = '/laundry-notification';


  static String getInitialRoute() => '$initial';
  static String getSplashRoute() => '$splash';
  static String getSignInRoute() => '$signIn';
  static String getVerificationRoute(String number) => '$verification?number=$number';
  static String getMainRoute(String page) => '$main?page=$page';
  static String getForgotPassRoute() => '$forgotPassword';
  static String getResetPasswordRoute(String phone, String token, String page) => '$resetPassword?phone=$phone&token=$token&page=$page';
  static String getOrderRoute({bool fromNav = false}) => '$order?fromNav=${fromNav.toString()}';
  // static String getOrderDetailsRoute(int id) => '$orderDetails?id=$id';
  static String getOrderDetailsRoute() => '$orderDetails';
  static String getOrderPickupDetailsRoute(OrderList orderList) {
    String data = base64Encode(utf8.encode(jsonEncode(orderList.toJson())));
    return '$orderPickupDetails?data=$data';
  }
  static String getUpdateProfileRoute() => '$updateProfile';
  static String getNotificationRoute() => '$notification';
  static String getRunningOrderRoute() => '$runningOrder';
  static String getTermsRoute() => '$terms';
  static String getPrivacyRoute() => '$privacy';
  static String getLanguageRoute() => '$language';
  static String getUpdateRoute(bool isUpdate) => '$update?update=${isUpdate.toString()}';
  static String getShiftRoute() => '$shift';
  static String getAddItemRoute() => '$addItem';
  static String getPickUpRoute(OrderList orderList) {
    String data = base64Encode(utf8.encode(jsonEncode(orderList.toJson())));
    return '$pickup?data=$data';
  }
  static String getSupportRoute() => '$support';
  static String getTrackPathRoute() => '$trackPath';
  static String getLaundryNotificationRoute() => '$laundryNotification';



  static List<GetPage> routes = [
    GetPage(name: initial, page: () => DashboardScreen(pageIndex: 0)),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: verification, page: () => VerificationScreen(number: Get.parameters['number'])),
    GetPage(name: main, page: () => DashboardScreen(
      pageIndex: Get.parameters['page'] == 'home' ? 0 : Get.parameters['page'] == 'order-request' ? 1
          : Get.parameters['page'] == 'order' ? 2 : Get.parameters['page'] == 'profile' ? 3 : 0,
    )),
    GetPage(name: forgotPassword, page: () => ForgetPassScreen()),
    GetPage(name: resetPassword, page: () => NewPassScreen(
      resetToken: Get.parameters['token'], number: Get.parameters['phone'], fromPasswordChange: Get.parameters['page'] == 'password-change',
    )),
    // GetPage(name: orderDetails, page: () {
    //   OrderDetailsScreen _orderDetails = Get.arguments;
    //   return _orderDetails != null ? _orderDetails : OrderDetailsScreen(
    //     orderModel: OrderModel(id: int.parse(Get.parameters['id'])), orderIndex: null, isRunningOrder: null,
    //   );
    // }),
    GetPage(name: order, page: () => OrderScreen(fromNav: Get.parameters['fromNav'] == 'true')),
    GetPage(name: orderDetails, page: () => OrderDetailsScreen()),
    GetPage(name: orderPickupDetails, page: () => OrderPickupDetailsScreen(
      orderList: OrderList.fromJson(jsonDecode(utf8.decode(base64Decode(Get.parameters['data'].replaceAll(' ', '+'))))),
    )),
    GetPage(name: updateProfile, page: () => UpdateProfileScreen()),
    GetPage(name: runningOrder, page: () => RunningOrderScreen()),
    GetPage(name: terms, page: () => HtmlViewerScreen(isPrivacyPolicy: false)),
    GetPage(name: privacy, page: () => HtmlViewerScreen(isPrivacyPolicy: true)),
    GetPage(name: language, page: () => ChooseLanguageScreen()),
    GetPage(name: update, page: () => UpdateScreen(isUpdate: Get.parameters['update'] == 'true')),
    GetPage(name: shift, page: () => DeliveryShiftScreen()),
    GetPage(name: addItem, page: () => AddItemScreen()),
    GetPage(name: pickup, page: () => PickUpMapScreen(showLocationDetails: Get.arguments != null ? Get.arguments : false, orderList: OrderList.fromJson(jsonDecode(utf8.decode(base64Decode(Get.parameters['data'].replaceAll(' ', '+'))))))),
    GetPage(name: support, page: () => SupportScreen()),
    GetPage(name: trackPath, page: () => AllOrderMap()),
    GetPage(name: laundryNotification, page: () => NotificationScreenLaundry()),

  ];
}