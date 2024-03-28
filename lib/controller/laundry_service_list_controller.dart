import 'package:efood_multivendor_driver/data/api/api_checker.dart';
import 'package:efood_multivendor_driver/data/repository/laundry_service_list_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/model/response/laundry_service_item_model.dart';

class LaundryServiceListController extends GetxController implements GetxService {
  final LaundryServiceListRepo laundryServiceListRepo;
  LaundryServiceListController({@required this.laundryServiceListRepo});

  List<Data> _serviceItemList;
  Campaign _campaign;
  Campaign get campaign => _campaign;
  int _serviceId = 0;
  bool _isLoading = false;

  List<Data> get serviceItemList => _serviceItemList;
  int get serviceId => _serviceId;
  bool get isLoading => _isLoading;

  Future<void> getServiceItemList ({@required int serviceId}) async{
    _isLoading = true;
    Response response = await laundryServiceListRepo.getServiceItemList(serviceId: serviceId);
    if(response.statusCode == 200) {
      _serviceItemList = [];
      LaundryServiceItemModel _laundryServiceItemModel = LaundryServiceItemModel.fromJson(response.body);
      //_serviceItemList.add(Data.fromJson(response.body));
        _campaign = _laundryServiceItemModel.campaign;
       _laundryServiceItemModel.data.forEach((data) {
         _serviceItemList.add(data);
       });
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();

  }

  String getServiceItemName(int serviceId) {
    String serviceName = '';
    for (int index = 0; index < _serviceItemList.length; index++) {
      if (_serviceItemList[index].id == serviceId) {
        serviceName = _serviceItemList[index].name;
        break;
      }
    }
    return serviceName;
  }

  List<Data> getServicesByLaundryItemId(int laundryItemId) {
    List<Data> _services = [];
    _serviceItemList.forEach((service) {
      if(service.id == laundryItemId) {
        _services.add(service);
      }
    });
    return _services;
  }

  void setServiceId(int serviceId) {
    _serviceId = serviceId;
    update();
  }

  //get all



}