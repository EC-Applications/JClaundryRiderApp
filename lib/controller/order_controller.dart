import 'dart:collection';
import 'dart:ui';

import 'package:efood_multivendor_driver/controller/laundry_cart_controller.dart';
import 'package:efood_multivendor_driver/data/api/api_checker.dart';
import 'package:efood_multivendor_driver/data/api/api_client.dart';
import 'package:efood_multivendor_driver/data/model/body/laundry_place_order_body.dart';
import 'package:efood_multivendor_driver/data/model/body/pick_order_map_body.dart';
import 'package:efood_multivendor_driver/data/model/body/update_status_body.dart';
import 'package:efood_multivendor_driver/data/model/response/all_order_track_model.dart';
import 'package:efood_multivendor_driver/data/model/response/deal_model.dart';
import 'package:efood_multivendor_driver/data/model/response/laundry_order_details_model.dart';
import 'package:efood_multivendor_driver/data/model/response/order_details_model.dart';
import 'package:efood_multivendor_driver/data/model/response/order_list_model.dart';
import 'package:efood_multivendor_driver/data/model/response/order_model.dart';
import 'package:efood_multivendor_driver/data/repository/order_repo.dart';
import 'package:efood_multivendor_driver/helper/route_helper.dart';
import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
import 'package:efood_multivendor_driver/view/screens/map/widget/permission_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../view/screens/order/widget/generate_invoice.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({@required this.orderRepo});

  List<OrderModel> _allOrderList;
  List<OrderModel> _currentOrderList;
  List<OrderModel> _deliveredOrderList;
  List<OrderModel> _completedOrderList;
  List<OrderModel> _latestOrderList;
  List<OrderDetailsModel> _orderDetailsModel;
  bool _isLoading = false;
  bool _isLoadingLocation = false;
  Position _position = Position(longitude: 0, latitude: 0, timestamp: null, accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
  Placemark _placeMark = Placemark(name: 'Unknown', subAdministrativeArea: 'Location', isoCountryCode: 'Found');
  String _otp = '';
  bool _paginate = false;
  int _pageSize;
  int _offset = 1;
  DealModel _orderDeals;
  bool _isEdited = false;
  int _selectedIndex = 0;
  bool _isOrderUpdated = false;
  bool _isOrderPicked = false;
  bool _markAsPicked = false;
  OrderList _orderListModel;
  int _selectedOrderIndex = 0;
  bool showZoom = true;


  //start
    List<String> _defredpickupselectedReasons = [];


  List<OrderList> _orderList;
  List<OrderList> _pickOrder;
  List<OrderList> _deliverOrder;
  List<OrderList> _pickUpOrderList;
  List<OrderList> _deliveryOrderList;
  List<OrderList> _pickedOrderList;
  List<OrderList> _myOrdersPickUpList;
  List<OrderList> _outForPickup;
  List<OrderList> _outForDelivery;
  List<OrderList> _orderHistory;
  int _tabIndex = 0;
  LaundryOrderDetails _laundryOrderDetailsModel;
  AllOrderTrackModel _allOrderTrackList;
  Set<Marker> _markers = Set.of([]);
  Set<Polyline> _polyline = Set.of([]);
  Routes _routesModel;
  XFile _takePicture;
  String _address;
  bool _isLocationPermission = false;
  String _filterValue = 'all';
  OrderListModel _paginationOrderListModel;
  OrderListModel _paginationHistoryOrderListModel;
  bool _takePicLoading = false;
  GoogleMapController _mapController;



  List<String> get defredpickupselectedReasons => _defredpickupselectedReasons;

  List<OrderModel> get allOrderList => _allOrderList;
  List<OrderModel> get currentOrderList => _currentOrderList;
  List<OrderModel> get deliveredOrderList => _deliveredOrderList;
  List<OrderModel> get completedOrderList => _completedOrderList;
  List<OrderModel> get latestOrderList => _latestOrderList;
  List<OrderDetailsModel> get orderDetailsModel => _orderDetailsModel;
  bool get isLoading => _isLoading;
  Position get position => _position;
  Placemark get placeMark => _placeMark;
  String get address => '${_placeMark.name} ${_placeMark.subAdministrativeArea} ${_placeMark.isoCountryCode}';
  String get otp => _otp;
  bool get paginate => _paginate;
  int get pageSize => _pageSize;
  int get offset => _offset;
  DealModel get orderDeals => _orderDeals;
  bool get isEdited => _isEdited;
  int get selectedIndex => _selectedIndex;
  bool get isOrderUpdated => _isOrderUpdated;
  bool get isOrderPicked => _isOrderPicked;
  bool get markAsPicked => _markAsPicked;
  int get tabIndex => _tabIndex;
  bool _isLoaded = false;
  String get currentAddress => _address;
  int get selectedOrderIndex => _selectedOrderIndex;
  String get filterValue => _filterValue;
  bool get isLoadingLocation => _isLoadingLocation;
  OrderListModel get paginationOrderListModel => _paginationOrderListModel;
  OrderListModel get paginationHistoryOrderListModel => _paginationHistoryOrderListModel;
  bool get takePicLoading => _takePicLoading;



  //start
  List<OrderList> get orderList => _orderList;
  List<OrderList> get pickOrder => _pickOrder;
  List<OrderList> get deliverOrder => _deliverOrder;
  List<OrderList> get outForPickup => _outForPickup;
  List<OrderList> get outForDelivery => _outForDelivery;
  List<OrderList> get orderHistory => _orderHistory;
  OrderList get orderListModel => _orderListModel;
  LaundryOrderDetails get laundryOrderDetailsModel => _laundryOrderDetailsModel;
  List<OrderList> get pickUpOrderList => _pickUpOrderList;
  List<OrderList> get deliveryOrderList => _deliveryOrderList;
  List<OrderList> get pickedOrderList => _pickedOrderList;
  List<OrderList> get myOrdersPickUpList => _myOrdersPickUpList;
  bool get isLoaded => _isLoaded;
  AllOrderTrackModel get allOrderTrackList => _allOrderTrackList;
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyline => _polyline;
  Routes get routesModel => _routesModel;
  XFile get takePicture => _takePicture;
  bool get isLocationPermission => _isLocationPermission;


  void setEditedValue (bool value, {bool notify = true}) {
    _isEdited = value;
    if(notify) update();
  }

  void setOrderUpdatedValue (bool value) {
    _isOrderUpdated = value;
    update();
  }

  void setOrderPickedValue (bool value, {bool notify = true}) {
    _isOrderPicked = value;
    if(notify) update();
  }


  void setLoading(bool value) {
    _isLoaded = value;
    update();
  }


  void setMarkAsPickedValue (bool value, {bool notify = true}) {
    _markAsPicked = value;
    if(notify) update();
  }


  void setSelectedIndex (int index) {
    _selectedIndex = index;
    update();
  }


  Future<void> getOrderList(int offset) async {
    _isLoading = true;
    Response response = await orderRepo.getOrderList(offset);
    if(response.statusCode == 200) {
      if(offset == 1) {
        _paginationOrderListModel = OrderListModel.fromJson(response.body);
      }else{
        _paginationOrderListModel.totalSize = OrderListModel.fromJson(response.body).totalSize;
        _paginationOrderListModel.offset = OrderListModel.fromJson(response.body).offset;
        _paginationOrderListModel.data.addAll(OrderListModel.fromJson(response.body).data);
      }
    }else {
      ApiChecker.checkApi(response);
    }
    orderListSeparateByStatus();
    _isLoading = false;
    update();
  }

  void orderListSeparateByStatus() {
    _orderList = [];
    _pickedOrderList = [];
    _pickUpOrderList = [];
    _deliveryOrderList = [];
    _myOrdersPickUpList = [];
    _outForPickup = [];
    _outForDelivery = [];

    if(_paginationOrderListModel?.data != null) {
      for(OrderList order in _paginationOrderListModel.data) {
        _orderList.add(order);
        if(order.orderStatus == AppConstants.PENDING || order.orderStatus == AppConstants.CONFIRMED || order.orderStatus == AppConstants.OUT_FOR_PICKUP) {
          _myOrdersPickUpList.add(order);
        }
        if(order.orderStatus == AppConstants.PENDING || order.orderStatus == AppConstants.CONFIRMED || order.orderStatus == AppConstants.OUT_FOR_PICKUP || order.orderStatus == AppConstants.PICKED_UP) {
          _pickUpOrderList.add(order);
        }
        if(order.orderStatus == AppConstants.READY_FOR_DELIVERY || order.orderStatus == AppConstants.OUT_FOR_DELIVERY ) {
          _deliveryOrderList.add(order);
        }
        if(order.orderStatus == AppConstants.PICKED_UP) {
          _pickedOrderList.add(order);
        }
        if(order.orderStatus == AppConstants.OUT_FOR_PICKUP) {
          _outForPickup.add(order);
        }
        if(order.orderStatus == AppConstants.OUT_FOR_DELIVERY) {
          _outForDelivery.add(order);
        }
      }
    }


  }



  Future<void> updateOrderStatus(UpdateStatusBody updateStatusBody, Function callback) async {
    _isLoading = true;
    Response response = await orderRepo.updateOrderStatus(updateStatusBody);

    if (response.statusCode == 200) {
      String message = response.body['message'];
      callback(true, '${'order'.tr} ${formatString(updateStatusBody.status)}', response.body['order_id'].toString());
      print('-------- Order update successfully ${response.body['order_id']} ----------');
    } else {
      callback(false, response.statusText, '-1');
      
    }
    _isLoading = false;
    update();
  }

  String formatString(String input) {
    String formattedString = input.replaceAll('_', ' ');
    List<String> words = formattedString.split(' ');

    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      if (i == 0) {
        words[i] = word.substring(0, 1).toUpperCase() + word.substring(1);
      } else {
        words[i] = word;
      }
    }

    return words.join(' ');
  }


  Future<void> updateOrder(LaundryPlaceOrderBody placeOrderBody, Function callback) async {
    _isLoading = true;
    update();
    print(placeOrderBody.toJson());
    Response response = await orderRepo.updateOrder(placeOrderBody);
    _isLoading = false;
    if (response.statusCode == 200) {
      String message = response.body['message'];
      callback(true, message, response.body['order_id'].toString());
      print('-------- Order placed successfully ${response.body['order_id']} ----------');
    } else {
      callback(false, response.statusText, '-1');
    }
    update();
  }

  Future<void> getAllRoutes() async {
    _isLoading = true;
    _allOrderTrackList = null;
    Response response = await orderRepo.getALlRoutes();
    if(response.statusCode == 200 && response.body['status'] == 'OK') {
      showZoom = true;
      _allOrderTrackList = AllOrderTrackModel.fromJson(response.body);
      List<LatLng> latLongList = decodeEncodedPolyline(_allOrderTrackList.routes.encodedPolyline);
      _polyline = HashSet();
      _markers = HashSet();
      _polyline.add(Polyline(polylineId: PolylineId('iSelectLaundry'), points: latLongList, width: 5, color: Get.theme.primaryColor));
      Uint8List pickUp = await convertAssetToUnit8List(Images.pickupMarker, width: 100,);
      Uint8List deliver = await convertAssetToUnit8List(Images.deliveryMarker, width: 100);

      for(OrderList orderList in _allOrderTrackList.orders) {
        _markers.add(Marker(
          markerId: MarkerId(orderList.id.toString()),
          position: checkPickUpDeliveryStatus(orderList.orderStatus) ? LatLng(orderList.pickupCoordinates.coordinates[1], orderList.pickupCoordinates.coordinates[0]) :
          LatLng(orderList.destinationCoordinates.coordinates[1], orderList.destinationCoordinates.coordinates[0]),
          infoWindow: InfoWindow(
            onTap: () async{
              Get.toNamed(RouteHelper.getOrderPickupDetailsRoute(orderList));
            },
            title: orderList.id.toString(),
            snippet: checkPickUpDeliveryStatus(orderList.orderStatus) ? 'pickup'.tr : 'delivery'.tr
          ),
          icon: BitmapDescriptor.fromBytes( checkPickUpDeliveryStatus(orderList.orderStatus) ? pickUp : deliver),
        ));
      }

    }else {
      ApiChecker.checkApi(Response(statusText: response.body['routes']['error_detail'] ?? response.bodyString));
    }
    _isLoading = false;
    update();
  }

  Future<void> getPickOrderRoute(PickOrderMapBody pickOrderMapBody, Function(bool isSuccess, String message, String orderId, {bool showSnackBar, bool isError}) callback, LaundryOrderDetails orderDetailsModel) async {
    _isLoadingLocation = true;
    update();
    print(pickOrderMapBody.toJson());
    Response response = await orderRepo.getPickOrderRoute(pickOrderMapBody);
    if (response.statusCode == 200 && response.body['status'] == 'OK') {
      // Position _currentPosition = await Geolocator.getCurrentPosition();
      showZoom = true;
      _routesModel = Routes.fromJson(response.body);
      List<LatLng> latLongList = decodeEncodedPolyline(_routesModel.encodedPolyline);
      _polyline = HashSet();
      _markers = HashSet();
      _polyline.add(Polyline(polylineId: PolylineId('iSelectLaundryPickup'), points: latLongList, width: 5, color: Get.theme.primaryColor));
      Uint8List pickUp = await convertAssetToUnit8List(Images.delivery_man_marker, width: 100);
      Uint8List deliver = await convertAssetToUnit8List(checkPickUpDeliveryStatus(orderDetailsModel.orderStatus) ? Images.pickupMarker : Images.deliveryMarker, width: 100);


      _markers.add(Marker(
        markerId: MarkerId(orderDetailsModel.id.toString()),
        position: LatLng(_position.latitude, _position.longitude),
        infoWindow: InfoWindow(
          onTap: () async{
            Get.toNamed(RouteHelper.getOrderPickupDetailsRoute(OrderList(id: orderDetailsModel.id)));
          },
          title: 'my_location'.tr,
          snippet: 'my_location'.tr,
        ),
        icon: BitmapDescriptor.fromBytes(pickUp),
      ));


      _markers.add(Marker(
          markerId: MarkerId(orderDetailsModel.id.toString()),
          position: LatLng(checkPickUpDeliveryStatus(orderDetailsModel.orderStatus) ? orderDetailsModel.pickupCoordinates.coordinates[1] :  orderDetailsModel.destinationCoordinates.coordinates[1],
              checkPickUpDeliveryStatus(orderDetailsModel.orderStatus) ? orderDetailsModel.pickupCoordinates.coordinates[0] : orderDetailsModel.destinationCoordinates.coordinates[0]),
          infoWindow: InfoWindow(
              onTap: () async{

                Get.toNamed(RouteHelper.getOrderPickupDetailsRoute(OrderList(id: orderDetailsModel.id)));

              },
              title: orderDetailsModel.id.toString(),
              snippet: (checkPickUpDeliveryStatus(orderDetailsModel.orderStatus))? 'pickup'.tr : 'delivery'.tr,
          ),
          icon: BitmapDescriptor.fromBytes(deliver),
      ));


      callback(true, '', '', showSnackBar: false);

    } else {
      // callback(false, 'current_position_is_too_far_from_destination'.tr, '');
      _polyline = HashSet();
      _markers = HashSet();
      showZoom = false;
      Uint8List pickUp = await convertAssetToUnit8List(Images.delivery_man_marker, width: 100);
      Uint8List deliver = await convertAssetToUnit8List(checkPickUpDeliveryStatus(orderDetailsModel.orderStatus) ? Images.pickupMarker : Images.deliveryMarker, width: 100);

      List<LatLng> latLongList = [LatLng(pickOrderMapBody.pickupCoordinates.first, pickOrderMapBody.pickupCoordinates.last), LatLng(pickOrderMapBody.destinationCoordinates.first, pickOrderMapBody.destinationCoordinates.last)];
      _polyline.add(Polyline(polylineId: PolylineId('iSelectLaundryPickup'), points: latLongList, width: 5, color: Get.theme.primaryColor));

      _markers.add(Marker(
        markerId: MarkerId(orderDetailsModel.id.toString()),
        position: LatLng(pickOrderMapBody.pickupCoordinates.first, pickOrderMapBody.pickupCoordinates.last),
        infoWindow: InfoWindow(
          onTap: () async{
            Get.toNamed(RouteHelper.getOrderPickupDetailsRoute(OrderList(id: orderDetailsModel.id)));
          },
          title: 'my_location'.tr,
          snippet: 'my_location'.tr,
        ),
        icon: BitmapDescriptor.fromBytes(pickUp),
      ));

      _markers.add(Marker(
        markerId: MarkerId(orderDetailsModel.id.toString()),
        position: LatLng(pickOrderMapBody.destinationCoordinates.first, pickOrderMapBody.destinationCoordinates.last),
        infoWindow: InfoWindow(
          onTap: () async{

            Get.toNamed(RouteHelper.getOrderPickupDetailsRoute(OrderList(id: orderDetailsModel.id)));

          },
          title: orderDetailsModel.id.toString(),
          snippet: (checkPickUpDeliveryStatus(orderDetailsModel.orderStatus))? 'pickup'.tr : 'delivery'.tr,
        ),
        icon: BitmapDescriptor.fromBytes(deliver),
      ));

      callback(false, response.body['error_detail'] ?? response.bodyString, '', showSnackBar: false, isError: true);
    }
    _isLoadingLocation = false;
    update();
  }

  Future<Uint8List> convertAssetToUnit8List(String imagePath, {int width = 50}) async {
    ByteData data = await rootBundle.load(imagePath);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png)).buffer.asUint8List();
  }


  Future<void> getOrderDetails(int orderId, {bool notify = true}) async {
    _isLoading = true;
    _laundryOrderDetailsModel = null;
    if(notify) {
      update();
    }
    Response response = await orderRepo.getOrdersDetails(orderId);
    _isLoading = false;
    if (response.statusCode == 200) {
      LaundryOrderDetailsModel _orderListModel = LaundryOrderDetailsModel.fromJson(response.body);
      _laundryOrderDetailsModel = _orderListModel.data;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }







  PickupAddress getAddress(String orderStatus, OrderList orderList) {
    if(orderStatus == AppConstants.PENDING || orderStatus == AppConstants.CONFIRMED || orderStatus == AppConstants.OUT_FOR_PICKUP || orderStatus == AppConstants.PICKED_UP) {
      return orderList.pickupAddress;
    }else if(orderStatus == AppConstants.OUT_FOR_DELIVERY || orderStatus == AppConstants.READY_FOR_DELIVERY || orderStatus == AppConstants.DELIVERED) {
      return orderList.destinationAddress;
    }else {
      return orderList.destinationAddress;
    }
  }


  String getTime(String orderStatus, {OrderList orderList, LaundryOrderDetails orderDetailsModel}) {
    if(orderStatus == AppConstants.PENDING) {
      return orderList != null ? orderList.pending : orderListModel.pending;
    }
    else if(orderStatus == AppConstants.CONFIRMED) {
      return orderList != null ? orderList.confirmed : orderListModel.confirmed;
    }
    else if(orderStatus == AppConstants.OUT_FOR_PICKUP) {
      return orderList != null ? orderList.outForPickup : orderListModel.outForPickup;
    }
    else if(orderStatus == AppConstants.PICKED_UP) {
      return orderList != null ? orderList.pickedUp : orderListModel.pickedUp;
    }
    else if(orderStatus == AppConstants.PROCESSING) {
      return orderList != null ? orderList.processing : orderListModel.processing;
    }
    else if(orderStatus == AppConstants.ARRIVED) {
      return orderList != null ? orderList.arrived : orderListModel.arrived;
    }
    else if(orderStatus == AppConstants.READY_FOR_DELIVERY) {
      return orderList != null ? orderList.readyForDelivery : orderListModel.readyForDelivery;
    }
    else if(orderStatus == AppConstants.OUT_FOR_DELIVERY) {
      return orderList != null ? orderList.outForDelivery : orderListModel.outForDelivery;
    }
    else if(orderStatus == AppConstants.CANCELED) {
      return orderList != null ? orderList.cancelled : orderListModel.cancelled;
    }else{
      return DateTime.now().toString();
    }
  }


  String getScheduleTime(bool fromDetails, {OrderList orderList, LaundryOrderDetails orderDetailsModel}) {
      return fromDetails ? orderList != null ? orderList.pickupScheduleAt : orderDetailsModel.pickupScheduleAt :  orderList != null ? orderList.deliveryScheduleAt : orderDetailsModel.deliveryScheduleAt;
  }






  void categorizeOrderList(List<OrderList> orderList) {
    _pickedOrderList = [];
    _pickUpOrderList = [];
    _deliveryOrderList = [];
    orderList.forEach((order) {
      if(order.orderStatus == AppConstants.PENDING || order.orderStatus == AppConstants.CONFIRMED || order.orderStatus == AppConstants.OUT_FOR_PICKUP ) {
        _pickUpOrderList.add(order);
      }
      else if(order.orderStatus == AppConstants.READY_FOR_DELIVERY || order.orderStatus == AppConstants.OUT_FOR_DELIVERY ) {
        _deliveryOrderList.add(order);
      }
      else if(order.orderStatus == AppConstants.PICKED_UP) {
        _pickedOrderList.add(order);
      }
    });

    update();
  }






  Future<void> getCurrentLocation() async {
    _isLoadingLocation = true;
    update();
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      _isLocationPermission = false;
      update();
    }
    if(permission == LocationPermission.denied) {
      showCustomSnackBar('you_have_to_allow'.tr);
      Get.back();
    }else if(permission == LocationPermission.deniedForever) {
      Get.dialog(PermissionDialog());
    }else {
      Position _currentPosition = await Geolocator.getCurrentPosition();
      _position = _currentPosition;
      _isLocationPermission = true;
    }
    _isLoadingLocation = false;
    update();
  }

  void getAddressFromGeocode(LatLng latLng) async {
    Response response = await orderRepo.getAddressFromGeocode(latLng);

    if(response.statusCode == 200 && response.body['status'] == 'OK') {
      _address = response.body['results'][0]['formatted_address'].toString();
    }else {
      showCustomSnackBar(response.body['error_message'] ?? response.bodyString);
    }
    update();
  }

  void setOtp(String otp) {
    _otp = otp;
    if(otp != '') {
      update();
    }
  }


  void setOrderList(OrderList orderList, {bool notify = true}) {
    _orderListModel = orderList;
    if(notify) {
      update();
    }
  }

  void setTabIndex(int index) {
    _tabIndex = index;
    update();
  }



  String removeUnderScore(String string) {
    String newString = string.replaceAll('_', ' ');
    return newString.capitalizeFirst;
  }


  bool checkPickUpDeliveryStatus (String status) {
    if(status == AppConstants.PENDING || status == AppConstants.CONFIRMED || status == AppConstants.OUT_FOR_PICKUP ) {
      return true;
    }else {
      return false;
    }
  }


  List<Cart> convertToCartList(LaundryOrderDetails laundryOrderDetails) {
    Map<int, List<LaundryItemList>> cartMap = {};


    laundryOrderDetails.details.forEach((Details laundryOrderDetail) {

      int serviceId = laundryOrderDetail.service.id;
      LaundryItemList item = LaundryItemList(
        laundryItemId: laundryOrderDetail.laundryItem.id,
        quantity: laundryOrderDetail.quantity,
        price: laundryOrderDetail.price.toDouble(),
        name: laundryOrderDetail.laundryItem.name,
        detailsId: laundryOrderDetail.id,
      );
      if (cartMap.containsKey(serviceId)) {
        cartMap[serviceId].add(item);
      } else {
        cartMap[serviceId] = [item];
      }
    });


    List<Cart> cartList = [];
    cartMap.forEach((int serviceId, List<LaundryItemList> itemsList) {
      Cart cart = Cart(
        servicesId: serviceId,
        items: itemsList,
      );
      cartList.add(cart);
    });

    return cartList;
  }

  String getItemName(int itemId) {
    String itemName = '';
    _laundryOrderDetailsModel.details.forEach((Details laundryOrderDetails) {
      if(laundryOrderDetails.laundryItem.id == itemId) {
        itemName = laundryOrderDetails.laundryItem.name;
      }
    });
    return itemName;
  }

  String getServiceName(int serviceId) {
    String serviceName = '';
    _laundryOrderDetailsModel.details.forEach((Details laundryOrderDetails) {
      if(laundryOrderDetails.service.id == serviceId) {
        serviceName = laundryOrderDetails.service.name;
      }
    });
    return serviceName;
  }


  int getDetailsId(int serviceId) {
    int detailsId = 0;
    _laundryOrderDetailsModel.details.forEach((Details laundryOrderDetails) {
      if(laundryOrderDetails.service.id == serviceId) {
        detailsId = laundryOrderDetails.id;
      }
    });
    return detailsId;
  }

  List<LatLng> decodeEncodedPolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;
    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      LatLng p = new LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
    update();
  }

  void boundMap(GoogleMapController googleMapController, LatLng originLatLng, LatLng destinationLatLng, {fromPickMap = false}) {
    // Animate to coordinate
    LatLngBounds bounds;

    if(googleMapController != null) {
      if (originLatLng.latitude < destinationLatLng.latitude) {
        bounds = LatLngBounds(
          southwest: originLatLng,
          northeast: destinationLatLng,
        );

      }else {
        bounds = LatLngBounds(
          southwest: destinationLatLng,
          northeast: originLatLng,
        );

      }
    }
    LatLng centerBounds = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude)/2,
      (bounds.northeast.longitude + bounds.southwest.longitude)/2,
    );

    if(showZoom) {
      googleMapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: centerBounds, zoom: GetPlatform.isWeb ? 10 : 17)));
      zoomToFit(googleMapController, bounds, centerBounds, padding: 1.5);
    }else{
      googleMapController.moveCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }




  }

  Future<void> zoomToFit(GoogleMapController controller, LatLngBounds bounds, LatLng centerBounds, {double padding = 0.5}) async {
    bool keepZoomingOut = true;

    while(keepZoomingOut) {
      final LatLngBounds screenBounds = await controller.getVisibleRegion();
      if(fits(bounds, screenBounds)){
        keepZoomingOut = false;
        final double zoomLevel = await controller.getZoomLevel() - padding;
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
        break;
      }
      else {
        // Zooming out by 0.1 zoom level per iteration
        final double zoomLevel = await controller.getZoomLevel() - 0.1;
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
      }
    }
  }

  bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
    final bool northEastLatitudeCheck = screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
    final bool northEastLongitudeCheck = screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

    final bool southWestLatitudeCheck = screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
    final bool southWestLongitudeCheck = screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

    return northEastLatitudeCheck && northEastLongitudeCheck && southWestLatitudeCheck && southWestLongitudeCheck;
  }


  Future<bool> uploadPicture(int orderId, String token) async {
    _takePicLoading = true;
    update();
    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      'order_id': orderId.toString(),
      'token': token
    });
    List<MultipartBody> _multiParts = [];
    if(_takePicture != null) {
      _multiParts.add(MultipartBody('picture', _takePicture));
    }

    Response response = await orderRepo.uploadPicture(_fields, _multiParts);
    _takePicLoading = false;
    bool _isSuccess;
    if (response.statusCode == 200) {

      showCustomSnackBar('pic_updated_successfully'.tr, isError: false);
      _isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
      _isSuccess = false;
    }
    update();
    return _isSuccess;
  }

  Future<void> captureImage() async {
    _takePicture = await ImagePicker().pickImage(source: ImageSource.camera);
    update();
  }

  void setSelectedOrderIndex(int index) {
    _selectedOrderIndex = index;
    update();
  }

  void setFilterValue(String value) {
    _filterValue = value;
    update();
  }

  Future<void> getOrderHistory(String type, int offset, {bool isUpdate = true}) async{
    _orderHistory = null;
    if(isUpdate) update();
    Response response = await orderRepo.getOrderHistoryList(type, offset);
    if(response.statusCode == 200) {
      if(offset == 1){
        _paginationHistoryOrderListModel = OrderListModel.fromJson(response.body);
      }else{
        _paginationHistoryOrderListModel.totalSize = OrderListModel.fromJson(response.body).totalSize;
        _paginationHistoryOrderListModel.offset = OrderListModel.fromJson(response.body).offset;
        _paginationHistoryOrderListModel.data.addAll(OrderListModel.fromJson(response.body).data);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    addOrderHistoryList();
    update();
  }

  void addOrderHistoryList() {
    _orderHistory = [];
    _paginationHistoryOrderListModel.data.forEach((order) {
      _orderHistory.add(order);
    });
  }

void handleReasonSelection(String reason) {
    _defredpickupselectedReasons = [reason];
    update();
  }



void printinoivce(){
   Printing.layoutPdf( 
                  format: PdfPageFormat.roll57,
                  onLayout: (PdfPageFormat format) async {
                  // Generate your PDF here
                  final pdf = await generatePdf(PdfPageFormat.roll57,orderDetailsModel: laundryOrderDetailsModel);
                  return pdf;
                });
                print("success");
              }
}







