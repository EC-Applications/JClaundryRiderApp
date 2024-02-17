import 'package:get/get.dart';

class RiderWalletController extends GetxController implements GetxService {

 bool _isButtonActive = true;

   bool get isButtonActive => _isButtonActive;

    bool setButtonActive(bool isActive) {
    _isButtonActive = isActive;
    update();
    return _isButtonActive;
  }
}