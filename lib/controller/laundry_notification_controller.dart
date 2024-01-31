
import 'package:efood_multivendor_driver/data/api/api_checker.dart';
import 'package:efood_multivendor_driver/data/model/response/laundry_notification_model.dart';
import 'package:efood_multivendor_driver/data/repository/laundry_notification_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaundryNotificationController extends GetxController implements GetxService {
  final LaundryNotificationRepo notificationRepo;
  LaundryNotificationController({@required this.notificationRepo});

  PaginationLaundryNotificationModel _paginationLaundryNotificationModel;

  PaginationLaundryNotificationModel get paginationLaundryNotificationModel => _paginationLaundryNotificationModel;

  Future<void> getNotificationList(int offset) async {
    Response response = await notificationRepo.getNotificationList(offset);
    if (response.statusCode == 200) {
      if(offset == 1) {
        _paginationLaundryNotificationModel = PaginationLaundryNotificationModel.fromJson(response.body);
      }else{
        _paginationLaundryNotificationModel.totalSize = PaginationLaundryNotificationModel.fromJson(response.body).totalSize;
        _paginationLaundryNotificationModel.offset = PaginationLaundryNotificationModel.fromJson(response.body).offset;
        _paginationLaundryNotificationModel.data.addAll(PaginationLaundryNotificationModel.fromJson(response.body).data);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveSeenNotificationCount(int count) {
    notificationRepo.saveSeenNotificationCount(count);
  }

  int getSeenNotificationCount() {
    return notificationRepo.getSeenNotificationCount();
  }

  void clearNotification() {
    _paginationLaundryNotificationModel = null;
  }


}