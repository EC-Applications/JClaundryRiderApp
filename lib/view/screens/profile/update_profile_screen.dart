import 'dart:io';

import 'package:efood_multivendor_driver/controller/auth_controller.dart';
import 'package:efood_multivendor_driver/controller/splash_controller.dart';
import 'package:efood_multivendor_driver/data/model/response/document_model.dart';
import 'package:efood_multivendor_driver/data/model/response/profile_model.dart';
import 'package:efood_multivendor_driver/helper/date_converter.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/custom_button.dart';
import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
import 'package:efood_multivendor_driver/view/base/my_text_field.dart';
import 'package:efood_multivendor_driver/view/screens/profile/widget/profile_bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _fatherNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Get.find<AuthController>().initData();
    Get.find<AuthController>().getProfile();
    Get.find<AuthController>().getDocumentTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<AuthController>(builder: (authController) {
        if(authController.profileModel != null && _firstNameController.text.isEmpty) {
          _firstNameController.text = authController.profileModel.fName ?? '';
          _lastNameController.text = authController.profileModel.lName ?? '';
          _fatherNameController.text = authController.profileModel.fatherName ?? '';
          _phoneController.text = authController.profileModel.phone ?? '';
          _emailController.text = authController.profileModel.email ?? '';
        }

        return (authController.profileModel != null && authController.documentList != null) ? ProfileBgWidget(
          backButton: true,
          circularImage: Center(child: Stack(children: [
            ClipOval(child: authController.pickedFile != null ? GetPlatform.isWeb ? Image.network(
              authController.pickedFile.path, width: 100, height: 100, fit: BoxFit.cover,
            ) : Image.file(
              File(authController.pickedFile.path), width: 100, height: 100, fit: BoxFit.cover,
            ) : FadeInImage.assetNetwork(
              placeholder: Images.placeholder,
              image: '${Get.find<SplashController>().configModel.baseUrls.deliveryManImageUrl}/${authController.profileModel.image ?? ''}',
              height: 100, width: 100, fit: BoxFit.cover,
              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 100, width: 100, fit: BoxFit.cover),
            )),
            Positioned(
              bottom: 0, right: 0, top: 0, left: 0,
              child: InkWell(
                onTap: () => authController.pickImage(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3), shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt, color: Colors.white),
                  ),
                ),
              ),
            ),
          ])),
          mainWidget: Column(children: [

            Expanded(child: Scrollbar(child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Center(child: SizedBox(width: 1170, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('${'zone'.tr}:', style: robotoRegular),
                  Text(
                    authController.profileModel.zone != null ? authController.profileModel.zone.name ?? '' : '',
                    style: robotoMedium,
                  ),
                ]),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('${'registered_at'.tr}:', style: robotoRegular),
                  Text(
                    authController.profileModel.createdAt != null ? DateConverter.isoStringToLocalDateOnly(authController.profileModel.createdAt) : '',
                    style: robotoMedium,
                  ),
                ]),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                Text(
                  'first_name'.tr,
                  style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).disabledColor),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                MyTextField(
                  hintText: 'first_name'.tr,
                  controller: _firstNameController,
                  focusNode: _firstNameFocus,
                  nextFocus: _lastNameFocus,
                  inputType: TextInputType.name,
                  capitalization: TextCapitalization.words,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                Text(
                  'last_name'.tr,
                  style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).disabledColor),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                MyTextField(
                  hintText: 'last_name'.tr,
                  controller: _lastNameController,
                  focusNode: _lastNameFocus,
                  nextFocus: _fatherNameFocus,
                  inputType: TextInputType.name,
                  capitalization: TextCapitalization.words,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                Text(
                  'father_name'.tr,
                  style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).disabledColor),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                MyTextField(
                  hintText: 'father_name'.tr,
                  controller: _fatherNameController,
                  focusNode: _fatherNameFocus,
                  nextFocus: _emailFocus,
                  inputType: TextInputType.name,
                  capitalization: TextCapitalization.words,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                Text(
                  'email'.tr,
                  style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).disabledColor),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                MyTextField(
                  hintText: 'email'.tr,
                  controller: _emailController,
                  focusNode: _emailFocus,
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                Row(children: [
                  Text(
                    'phone'.tr,
                    style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).disabledColor),
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Text('(${'non_changeable'.tr})', style: robotoRegular.copyWith(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL, color: Theme.of(context).colorScheme.error,
                  )),
                ]),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                MyTextField(
                  hintText: 'phone'.tr,
                  controller: _phoneController,
                  focusNode: _phoneFocus,
                  inputType: TextInputType.phone,
                  isEnabled: false,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                authController.documentList != null ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: authController.documentList.length,
                  itemBuilder: (context, index) {
                    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                      Text(
                        authController.documentList[index].documentType.documentTitle,
                        style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).disabledColor),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      MyTextField(
                        hintText: authController.documentList[index].documentType.documentTitle,
                        controller: authController.documentList[index].controller,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.text,
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                      SizedBox(height: 120, child: ListView.builder(
                        itemCount: authController.documentList[index].documentType.fileCount,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                            child: Stack(children: [
                              authController.documentList[index].documentType.documentType == 'image' ? ClipRRect(
                                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                child: authController.documentList[index].files[i] != null ? GetPlatform.isWeb ? Image.network(
                                  authController.documentList[index].files[i].path, width: 120, height: 120, fit: BoxFit.cover,
                                ) : Image.file(
                                  File(authController.documentList[index].files[i].path), width: 120, height: 120, fit: BoxFit.cover,
                                ) : FadeInImage.assetNetwork(
                                  placeholder: Images.placeholder,
                                  image: '${Get.find<SplashController>().configModel.baseUrls.deliveryManImageUrl}'
                                      '/${authController.documentList[index].stringFiles[i] ?? ''}',
                                  height: 120, width: 120, fit: BoxFit.cover,
                                  imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 120, width: 120, fit: BoxFit.cover),
                                ),
                              ) : SizedBox(width: 120, height: 120, child: Center(child: Padding(
                                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: Text(
                                  authController.documentList[index].files[i] != null ? authController.documentList[index].files[i].name
                                      : authController.documentList[index].stringFiles[i] != null
                                      ? authController.documentList[index].stringFiles[i] : 'no_attachment'.tr,
                                  style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL), maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () => authController.pickFile(
                                    index, i, authController.documentList[index].documentType.documentType,
                                  ),
                                  child: Container(
                                    height: 120, width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                      border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(25),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 2, color: Colors.white),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        authController.documentList[index].documentType.documentType == 'image' ? Icons.camera_alt
                                            : Icons.picture_as_pdf,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        },
                      )),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                    ]);
                  },
                ) : Center(child: CircularProgressIndicator()),

              ]))),
            ))),

            !authController.isLoading ? CustomButton(
              onPressed: () => _updateProfile(authController),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              buttonText: 'update'.tr,
            ) : Center(child: CircularProgressIndicator()),

          ]),
        ) : Center(child: CircularProgressIndicator());
      }),
    );
  }

  void _updateProfile(AuthController authController) async {
    String _firstName = _firstNameController.text.trim();
    String _lastName = _lastNameController.text.trim();
    String _fatherName = _fatherNameController.text.trim();
    String _email = _emailController.text.trim();
    String _phoneNumber = _phoneController.text.trim();
    for(DocumentModel document in authController.documentList) {
      bool _hasData = false;
      int _nullIndex;
      String _missingDataText;
      for(int index=0; index<document.files.length; index++) {
        if(document.files[index] != null) {
          _hasData = true;
        }else {
          if(_nullIndex == null) {
            _nullIndex = index;
          }
          if(_missingDataText == null && document.stringFiles[index] == null) {
            _missingDataText = '${'choose_attachment_of'.tr} ${index + 1} ${document.documentType.documentTitle}';
          }
        }
      }
      if(document.controller.text.trim().isEmpty) {
        showCustomSnackBar('${'enter'.tr} ${document.documentType.documentTitle}');
        return;
      }else if(_hasData && document.files.contains(null)) {
        showCustomSnackBar('${'choose_attachment_of'.tr} ${_nullIndex + 1} ${document.documentType.documentTitle}');
        return;
      }else if(_missingDataText != null) {
        showCustomSnackBar(_missingDataText);
        return;
      }
    }
    if (_firstName.isEmpty) {
      showCustomSnackBar('enter_your_first_name'.tr);
    }else if (_lastName.isEmpty) {
      showCustomSnackBar('enter_your_last_name'.tr);
    }else if (_fatherName.isEmpty) {
      showCustomSnackBar('enter_your_father_name'.tr);
    }else if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr);
    }else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar('enter_a_valid_email_address'.tr);
    }else if (_phoneNumber.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    }else if (_phoneNumber.length < 6) {
      showCustomSnackBar('enter_a_valid_phone_number'.tr);
    } else {
      ProfileModel _updatedUser = ProfileModel(
        fName: _firstName, lName: _lastName, email: _email, phone: _phoneNumber, fatherName: _fatherName,
      );
      authController.updateUserInfo(_updatedUser, Get.find<AuthController>().getUserToken());
    }
  }
}
