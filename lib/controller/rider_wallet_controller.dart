import 'package:efood_multivendor_driver/data/repository/rider_repo.dart';
import 'package:get/get.dart';
import '../data/api/api_checker.dart';
import '../data/model/response/rider_wallet_model.dart';

class RiderWalletController extends GetxController implements GetxService {

 bool _isButtonActive = true;
 bool _isLoading = false;
 final RiderRepo riderRepo;
 RiderWalletController({this.riderRepo});
 RiderWalletModel _walletData;
 RiderWalletModel get walletData => _walletData;
 bool get isLoading => _isLoading;

  bool get isButtonActive => _isButtonActive;
  bool setButtonActive(bool isActive) {
    _isButtonActive = isActive;
    update();
    return _isButtonActive;
  }

Future<void> getWalletDetails () async{
    _isLoading = true;
    Response response = await riderRepo.getWalletDetails();
    if(response.statusCode == 200) {
      _walletData = RiderWalletModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }
}