import 'package:efood_multivendor_driver/data/api/api_checker.dart';
import 'package:efood_multivendor_driver/data/model/response/laundry_service_model.dart';
import 'package:efood_multivendor_driver/data/repository/laundry_service_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LaundryServiceController extends GetxController implements GetxService {
  final LaundryServiceRepo laundryServiceRepo;
  LaundryServiceController({@required this.laundryServiceRepo});


  int _servicesId = 0;
  List<LaundryServiceModel> _serviceList;


  int get servicesId => _servicesId;
  List<LaundryServiceModel> get serviceList => _serviceList;

  void setServicesId(int serviceId) {
    _servicesId = serviceId;
    update();
  }


  Future<void> getServiceList () async{
    Response response = await laundryServiceRepo.getServiceList();
    if(response.statusCode == 200) {
      _serviceList = [];
      response.body.forEach((service) => _serviceList.add(LaundryServiceModel.fromJson(service)));
    } else {
      ApiChecker.checkApi(response);
    }
    update();

  }

  String getServiceName(int serviceId) {
    String serviceName = '';
    if(_serviceList != null) {
      for (int index = 0; index < _serviceList.length; index++) {
        if (_serviceList[index].id == serviceId) {
          serviceName = _serviceList[index].name;
          break;
        }
      }
    }

    return serviceName;
  }



  int getServiceIndex(int serviceId) {
    int index = 0;
    for (int i = 0; i < _serviceList.length; i++) {
      if (_serviceList[i].id == serviceId) {
        index = i;
        break;
      }
    }
    return index;
  }

//from serviceList get all the serviceItemList





}