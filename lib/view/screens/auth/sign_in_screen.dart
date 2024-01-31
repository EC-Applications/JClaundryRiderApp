import 'package:country_code_picker/country_code.dart';
import 'package:efood_multivendor_driver/controller/auth_controller.dart';
import 'package:efood_multivendor_driver/controller/localization_controller.dart';
import 'package:efood_multivendor_driver/controller/splash_controller.dart';
import 'package:efood_multivendor_driver/helper/route_helper.dart';
import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/custom_button.dart';
import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
import 'package:efood_multivendor_driver/view/base/custom_text_field.dart';
import 'package:efood_multivendor_driver/view/screens/auth/widget/code_picker_widget.dart';
import 'package:efood_multivendor_driver/view/screens/auth/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInScreen extends StatelessWidget {
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String _countryDialCode = Get.find<AuthController>().getUserCountryCode().isNotEmpty ? Get.find<AuthController>().getUserCountryCode()
        : CountryCode.fromCountryCode(Get.find<SplashController>().configModel.country).dialCode;
    _phoneController.text =  Get.find<AuthController>().getUserNumber() ?? '';
    _passwordController.text = Get.find<AuthController>().getUserPassword() ?? '';

    return Scaffold(
      body: SafeArea(child: Scrollbar(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: GetBuilder<AuthController>(builder: (authController) {

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
              // Container(
              //   alignment: Alignment.center,
              //   height: 46,
              //   width: 46,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     border: Border.all(
              //       color: Theme.of(context).hintColor.withOpacity(.2),
              //       width: 2
              //     )
              //   ),
              //   child: Image.asset(
              //     Images.arrow_left,
              //     color: Theme.of(context).textTheme.bodyLarge.color,
              //     height: 22,
              //     width: 22,
              //   ),
              // ),
              SizedBox(height: 30,),


              Text('sign_in'.tr, style: robotoBlack.copyWith(fontSize: 30)),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Text(
                'login_using_your_registered_mobile_number'.tr,
                style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
              ),
              SizedBox(height: 50,),

              TitleWidget(
                title: 'mobile_number',
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_LARGE)),
                  border:  Border.all(
                      color: Theme.of(context).hintColor.withOpacity(.2),
                      width: 1
                  ),
                  color: Theme.of(context).cardColor
                ),
                child: Row(children: [
                  CodePickerWidget(
                    onChanged: (CountryCode countryCode) {
                      _countryDialCode = countryCode.dialCode;
                    },
                    initialSelection: _countryDialCode != null ? _countryDialCode : Get.find<LocalizationController>().locale.countryCode,
                    favorite: [_countryDialCode],
                    enabled: false,
                    showDropDownButton: true,
                    padding: EdgeInsets.zero,
                    showFlagMain: true,
                    dialogBackgroundColor: Theme.of(context).cardColor,
                    flagWidth: 30,
                    textStyle: robotoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).textTheme.bodyLarge.color,
                    ),
                  ),
                  Expanded(child: CustomTextField(
                    hintText: 'enter_your_number'.tr,
                    controller: _phoneController,
                    focusNode: _phoneFocus,
                    nextFocus: _passwordFocus,
                    inputType: TextInputType.phone,
                    divider: false,

                  )),
                ]),
              ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

              TitleWidget(
                title: 'password',
              ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_LARGE)),
                  border:  Border.all(
                      color: Theme.of(context).hintColor.withOpacity(.2),
                      width: 1
                  ),
                  color: Theme.of(context).cardColor
                ),
                child: CustomTextField(
                  hintText: 'enter_your_password'.tr,
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.visiblePassword,
                  prefixIcon: Images.lock,
                  isPassword: true,
                  onSubmit: (text) => GetPlatform.isWeb ? _login(
                    authController, _phoneController, _passwordController, _countryDialCode, context,
                  ) : null,
                ),
              ),
              SizedBox(height: 10),

              Row(children: [
                Expanded(
                  child: ListTile(
                    onTap: () => authController.toggleRememberMe(),
                    leading: Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: authController.isActiveRememberMe,
                      onChanged: (bool isChecked) => authController.toggleRememberMe(),
                    ),
                    title: Text('remember_me'.tr),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    horizontalTitleGap: 0,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(RouteHelper.getForgotPassRoute()),
                  child: Text('${'forgot_password'.tr}?'),
                ),
              ]),
              SizedBox(height: 50),

              !authController.isLoading ? CustomButton(
                fontColor: Theme.of(context).textTheme.bodyLarge.color,
                buttonText: 'sign_in'.tr,
                onPressed: () => _login(authController, _phoneController, _passwordController, _countryDialCode, context),
              ) : Center(child: CircularProgressIndicator()),
              SizedBox(height: Get.find<SplashController>().configModel.toggleDmRegistration ? Dimensions.PADDING_SIZE_SMALL : 0),

              Get.find<SplashController>().configModel.toggleDmRegistration ? TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(1, 40),
                ),
                onPressed: () async {
                  if(await canLaunch('${AppConstants.BASE_URL}/deliveryman/apply')) {
                    launch('${AppConstants.BASE_URL}/deliveryman/apply');
                  }
                },
                child: RichText(text: TextSpan(children: [
                  TextSpan(text: '${'join_as_a'.tr} ', style: robotoRegular.copyWith(color: Theme.of(context).disabledColor)),
                  TextSpan(text: 'delivery_man'.tr, style: robotoMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge.color)),
                ])),
              ) : SizedBox(),

            ],);
          }),
        ),
      )),
    );
  }

  void _login(AuthController authController, TextEditingController phoneCtlr, TextEditingController passCtlr, String countryCode, BuildContext context) async {
    String _phone = phoneCtlr.text.trim();
    String _password = passCtlr.text.trim();

    String _numberWithCountryCode = countryCode+_phone;
    bool _isValid = false;
    try {
      PhoneNumber phoneNumber = await PhoneNumberUtil().parse(_numberWithCountryCode);
      _numberWithCountryCode = '+'+phoneNumber.countryCode+phoneNumber.nationalNumber;
      _isValid = true;
    }catch(e) {}

    if (_phone.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    }else if (!_isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    }else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    }else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    }else {
      authController.login(_numberWithCountryCode, _password).then((status) async {
        if (status.isSuccess) {
          if (authController.isActiveRememberMe) {
            authController.saveUserNumberAndPassword(_phone, _password, countryCode);
          } else {
            authController.clearUserNumberAndPassword();
          }
          await Get.find<AuthController>().getProfile();
          Get.offAllNamed(RouteHelper.getInitialRoute());
        }
      });
    }

    /*print('------------1');
    final _imageData = await Http.get(Uri.parse('https://cdn.dribbble.com/users/1622791/screenshots/11174104/flutter_intro.png'));
    print('------------2');
    String _stringImage = base64Encode(_imageData.bodyBytes);
    print('------------3 {$_stringImage}');
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.setString('image', _stringImage);
    print('------------4');
    Uint8List _uintImage = base64Decode(_sp.getString('image'));
    authController.setImage(_uintImage);
    //await _thetaImage.writeAsBytes(_imageData.bodyBytes);
    print('------------5');*/
  }
}
