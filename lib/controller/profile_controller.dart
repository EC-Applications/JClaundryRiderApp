
import 'package:efood_multivendor_driver/data/api/api_checker.dart';
import 'package:efood_multivendor_driver/data/model/response/deliveryman_profile_model.dart';
import 'package:efood_multivendor_driver/data/repository/profile_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController implements GetxService{
  final ProfileRepo profileRepo;
  ProfileController({@required this.profileRepo});

  bool _isSelected = true;
  Color _expressService = Color(0xFFEB001B);
  Color _appointment = Color(0xFF133BB7);
  Color _normal = Color(0xFF4CD964);
  Color _rework = Color(0xFFFF5F00);



  bool get isSelected => _isSelected;
  Color get expressService => _expressService;
  Color get appointment => _appointment;
  Color get normal => _normal;
  Color get rework => _rework;

  DeliveryManProfileModel _deliveryManProfileModel;

  DeliveryManProfileModel get deliveryManProfileModel => _deliveryManProfileModel;

  void setSelectedValue (bool value) {
    _isSelected = value;
    update();
  }


  Future<void> getProfileOrderStatus() async {
    Response response = await profileRepo.getProfileOrderStatus();
    if (response.statusCode == 200) {
      _deliveryManProfileModel = DeliveryManProfileModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

}