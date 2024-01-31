import 'dart:async';
import 'dart:convert';

import 'package:efood_multivendor_driver/data/api/api_checker.dart';
import 'package:efood_multivendor_driver/data/api/api_client.dart';
import 'package:efood_multivendor_driver/data/model/body/record_location_body.dart';
import 'package:efood_multivendor_driver/data/model/response/document_model.dart';
import 'package:efood_multivendor_driver/data/model/response/document_type_model.dart';
import 'package:efood_multivendor_driver/data/model/response/profile_model.dart';
import 'package:efood_multivendor_driver/data/model/response/response_model.dart';
import 'package:efood_multivendor_driver/data/model/response/shift_model.dart';
import 'package:efood_multivendor_driver/data/repository/auth_repo.dart';
import 'package:efood_multivendor_driver/helper/date_converter.dart';
import 'package:efood_multivendor_driver/helper/route_helper.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/view/base/confirmation_dialog.dart';
import 'package:efood_multivendor_driver/view/base/custom_alert_dialog.dart';
import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
import 'package:efood_multivendor_driver/view/screens/dashboard/widget/suspension_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart' as GeoCoding;
import 'package:location/location.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({@required this.authRepo}) {
   _notification = authRepo.isNotificationActive();
  }

  bool _isLoading = false;
  bool _notification = true;
  ProfileModel _profileModel;
  XFile _pickedFile;
  XFile _takePicture;
  Timer _timer;
  Location _location = Location();
  List<ShiftModel> _shiftList;
  int _shiftIndex = -1;
  Timer _shiftTimer;
  List<DocumentModel> _documentList;
  List<DocumentTypeModel> _documentTypes;

  bool get isLoading => _isLoading;
  bool get notification => _notification;
  ProfileModel get profileModel => _profileModel;
  XFile get pickedFile => _pickedFile;
  XFile get takePicture => _takePicture;
  List<ShiftModel> get shiftList => _shiftList;
  int get shiftIndex => _shiftIndex;
  List<DocumentModel> get documentList => _documentList;

  Future<ResponseModel> login(String phone, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(phone, password);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token'], response.body['zone_wise_topic']);
      await authRepo.updateToken();
      responseModel = ResponseModel(true, 'successful');
    } else {
      responseModel = ResponseModel(false, response.statusText);
      if(response.statusCode == 402) {
        Get.find<AuthController>().clearSharedData();
        Get.find<AuthController>().stopLocationRecord();
        Get.offAllNamed(RouteHelper.getSignInRoute());
        Get.dialog(SuspensionDialog(description: response.statusText), barrierDismissible: false);
      }else {
        showCustomSnackBar(response.statusText);
      }
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> getProfile() async {
    Response response = await authRepo.getProfileInfo();
    if (response.statusCode == 200) {
      _profileModel = ProfileModel.fromJson(response.body);
      initDocumentData();
      if (_profileModel.active == 1) {
        LocationPermission permission = await Geolocator.checkPermission();
        if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever
            || (GetPlatform.isIOS ? false : permission == LocationPermission.whileInUse)) {
          Get.dialog(ConfirmationDialog(
            icon: Images.location_permission,
            iconSize: 200,
            hasCancel: false,
            description: 'this_app_collects_location_data'.tr,
            onYesPressed: () {
              Get.back();
              _checkPermission(() => startLocationRecord());
            },
          ), barrierDismissible: false);
        }else {
          startLocationRecord();
        }
      } else {
        stopLocationRecord();
        if(_profileModel.active == 1) {
          // updateActiveStatus();
        }
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<bool> updateUserInfo(ProfileModel updateUserModel, String token) async {
    _isLoading = true;
    update();
    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      '_method': 'put', 'f_name': updateUserModel.fName, 'l_name': updateUserModel.lName,
      'father_name' : updateUserModel.fatherName,
      'email': updateUserModel.email, 'token': getUserToken()
    });
    List<MultipartBody> _multiParts = [];
    if(_pickedFile != null) {
      _multiParts.add(MultipartBody('image', _pickedFile));
    }
    for(int index=0; index<_documentList.length; index++) {
      _fields.addAll({
        'document[$index][type]': _documentList[index].documentType.documentTitle,
        'document[$index][data]': _documentList[index].controller.text.trim(),
        'document[$index][document_type]': _documentList[index].documentType.documentType,
      });
      for(int i=0; i<_documentList[index].files.length; i++) {
        if(_documentList[index].files[i] != null) {
          _multiParts.add(MultipartBody(
            'document[$index][files][]',
            _documentList[index].files[i],
          ));
        }
      }
    }
    Response response = await authRepo.updateProfile(_fields, _multiParts, token);
    _isLoading = false;
    bool _isSuccess;
    if (response.statusCode == 200) {
      getProfile();
      _profileModel = updateUserModel;
      showCustomSnackBar('profile_updated_successfully'.tr, isError: false);
      _isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
      _isSuccess = false;
    }
    update();
    return _isSuccess;
  }

  void pickImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    update();
  }

  void pickFile(int index, int i, String fileTYpe) async {
    List<String> _fileType = fileTYpe == 'image' ? ['png', 'jpg', 'jpeg'] : ['pdf'];
    FilePickerResult _result = await FilePicker.platform.pickFiles(
      type: FileType.custom, allowedExtensions: _fileType,
    );
    if (_result != null) {
      _documentList[index].files[i] = XFile(
        _result.files.single.path,
        bytes: _result.files.single.bytes,
        mimeType: _result.files.single.extension,
        name: _result.files.single.name,
        length: _result.files.single.size,
        lastModified: DateTime.now(),
      );
    }
    update();
  }

  Future<bool> changePassword(ProfileModel updatedUserModel, String password) async {
    _isLoading = true;
    update();
    bool _isSuccess;
    Response response = await authRepo.changePassword(updatedUserModel, password);
    _isLoading = false;
    if (response.statusCode == 200) {
      String message = response.body["message"];
      showCustomSnackBar(message, isError: false);
      _isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
      _isSuccess = false;
    }
    update();
    return _isSuccess;
  }

  void startLocationRecord() {
    _location.enableBackgroundMode(enable: true);
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      recordLocation();
    });
  }

  void stopLocationRecord() {
    _location.enableBackgroundMode(enable: false);
    _timer?.cancel();
  }

  Future<void> recordLocation() async {
    print('--------------Adding location');
    final LocationData _locationResult = await _location.getLocation();
    print('This is current Location: Latitude: ${_locationResult.latitude} Longitude: ${_locationResult.longitude}');
    String _address;
    try{
      List<GeoCoding.Placemark> _addresses = await GeoCoding.placemarkFromCoordinates(_locationResult.latitude, _locationResult.longitude);
      GeoCoding.Placemark _placeMark = _addresses.first;
      _address = '${_placeMark.name}, ${_placeMark.subAdministrativeArea}, ${_placeMark.isoCountryCode}';
    }catch(e) {
      _address = 'Unknown Location Found';
    }
    RecordLocationBody _recordLocation = RecordLocationBody(
      location: _address, latitude: _locationResult.latitude, longitude: _locationResult.longitude,
    );

    Response _response = await authRepo.recordLocation(_recordLocation);
    if(_response.statusCode == 200) {
      print('--------------Added record Lat: ${_recordLocation.latitude} Lng: ${_recordLocation.longitude} Loc: ${_recordLocation.location}');
    }else {
      print('--------------Failed record');
    }
  }

  Future<ResponseModel> forgetPassword(String email) async {
    _isLoading = true;
    update();
    Response response = await authRepo.forgetPassword(email);

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> getShifts() async {
    _shiftIndex = -1;
    Response response = await authRepo.getShifts();
    if (response.statusCode == 200) {
      _shiftList = [];
      response.body.forEach((shift) => _shiftList.add(ShiftModel.fromJson(shift)));
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void setShiftIndex(int index) {
    _shiftIndex = index;
    update();
  }

  Future<void> storeShifts(ShiftModel shift, bool futureTime) async {
    _isLoading = true;
    update();
    Response response = await authRepo.storeShift(shift.id);
    if (response.statusCode == 200) {
      DateTime _startTime = DateConverter.stringTimeToDate(shift.startTime);
      DateTime _endTime = DateConverter.stringTimeToDate(shift.endTime);
      _startTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, _startTime.hour, _startTime.minute);
      _endTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, _endTime.hour, _endTime.minute);
      ShiftModel _shift = ShiftModel(id: shift.id, title: shift.title, startTime: shift.startTime, endTime: shift.endTime);
      _shift.startTime = DateConverter.localDateToIsoString(_startTime);
      _shift.endTime = DateConverter.localDateToIsoString(_endTime);
      authRepo.setShiftData(_shift);
      Get.back(result: futureTime ? null : true);
      if(futureTime) {
        showCustomSnackBar('subscribed_to_shift'.tr, isError: false);
      }
    } else {
      Get.back();
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  ShiftModel getCurrentShift() {
    String _shifts = authRepo.getShiftData();
    if(_shifts != null) {
      ShiftModel _shift = ShiftModel.fromJson(jsonDecode(_shifts));
      DateTime _startTime = DateConverter.isoStringToLocalDate(_shift.startTime);
      DateTime _endTime = DateConverter.isoStringToLocalDate(_shift.endTime);
      DateTime _start = DateTime(_startTime.year, _startTime.month, _startTime.day);
      DateTime _now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      if(_start.isAtSameMomentAs(_now)) {
        if(_startTime.isBefore(DateTime.now()) && _endTime.isAfter(DateTime.now())) {
          _shift.startTime = DateConverter.dateTimeToStringTime(_startTime);
          _shift.endTime = DateConverter.dateTimeToStringTime(_endTime);
          return _shift;
        }else if(_endTime.isBefore(DateTime.now())) {
          authRepo.clearShift();
        }
      }else {
        authRepo.clearShift();
      }
    }
    return null;
  }

  bool hasFutureShift() {
    String _shifts = authRepo.getShiftData();
    if(_shifts != null) {
      ShiftModel _shift = ShiftModel.fromJson(jsonDecode(_shifts));
      DateTime _startTime = DateConverter.isoStringToLocalDate(_shift.startTime);
      DateTime _endTime = DateConverter.isoStringToLocalDate(_shift.endTime);
      DateTime _start = DateTime(_startTime.year, _startTime.month, _startTime.day);
      DateTime _now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      if(_start.isAtSameMomentAs(_now)) {
        if(_startTime.isAfter(DateTime.now())) {
          _shift.startTime = DateConverter.dateTimeToStringTime(_startTime);
          _shift.endTime = DateConverter.dateTimeToStringTime(_endTime);
          return true;
        }
      }else {
        authRepo.clearShift();
      }
    }
    return false;
  }

  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  void startStreamForShift() {
    if(getCurrentShift() != null && _profileModel.active == 1) {
      DateTime _endTime = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, DateConverter.stringTimeToDate(getCurrentShift().endTime).day,
        DateConverter.stringTimeToDate(getCurrentShift().endTime).minute,
      );
      int _timeDifference = DateTime.now().difference(_endTime).inMinutes;
      _shiftTimer?.cancel();
      _shiftTimer = Timer(Duration(minutes: _timeDifference), () {
        if(_profileModel.active == 1) {
          // updateActiveStatus();
        }else {
          _shiftTimer?.cancel();
        }
      });
    }
  }

  Future<ResponseModel> verifyToken(String number) async {
    _isLoading = true;
    update();
    Response response = await authRepo.verifyToken(number, _verificationCode);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> resetPassword(String resetToken, String phone, String password, String confirmPassword) async {
    _isLoading = true;
    update();
    Response response = await authRepo.resetPassword(resetToken, phone, password, confirmPassword);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }


  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password, String countryCode) {
    authRepo.saveUserNumberAndPassword(number, password, countryCode);
  }

  String getUserNumber() {
    return authRepo.getUserNumber() ?? "";
  }

  String getUserCountryCode() {
    return authRepo.getUserCountryCode() ?? "";
  }

  String getUserPassword() {
    return authRepo.getUserPassword() ?? "";
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  bool setNotificationActive(bool isActive) {
    _notification = isActive;
    authRepo.setNotificationActive(isActive);
    update();
    return _notification;
  }

  void initData() {
    _pickedFile = null;
    _documentList = null;
  }

  void _checkPermission(Function callback) async {
    LocationPermission permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied
        || (GetPlatform.isIOS ? false : permission == LocationPermission.whileInUse)) {
      Get.dialog(CustomAlertDialog(description: 'you_denied'.tr, onOkPressed: () async {
        Get.back();
        await Geolocator.requestPermission();
        _checkPermission(callback);
      }), barrierDismissible: false);
    }else if(permission == LocationPermission.deniedForever) {
      Get.dialog(CustomAlertDialog(description: 'you_denied_forever'.tr, onOkPressed: () async {
        Get.back();
        await Geolocator.openAppSettings();
        _checkPermission(callback);
      }), barrierDismissible: false);
    }else {
      callback();
    }
  }

  Future<void> getDocumentTypes() async {
    if(_documentTypes == null) {
      Response response = await authRepo.getDocumentTypes();
      if (response.statusCode == 200) {
        _documentTypes = [];
        response.body.forEach((documentType) => _documentTypes.add(DocumentTypeModel.fromJson(documentType)));
        initDocumentData();
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  void initDocumentData() {
    if(_profileModel != null && _documentTypes != null) {
      _documentList = [];
      for(DocumentTypeModel type in _documentTypes) {
        List<XFile> _files = [];
        List<String> _stringFiles = [];
        Documents _document;
        try {
          _document = _profileModel.documents.firstWhere((document) => document.type == type.documentTitle);
        }catch(e) {}
        for(int index=0; index<type.fileCount; index++) {
          _files.add(null);
          _stringFiles.add((_document != null && _document.files.length > index) ? _document.files[index] : null);
        }
        _documentList.add(DocumentModel(TextEditingController(text: _document != null ? _document.data ?? '' : ''), _files, _stringFiles, type));
      }
    }
  }

}