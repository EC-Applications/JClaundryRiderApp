import 'package:efood_multivendor_driver/data/model/response/order_list_model.dart';

class AllOrderTrackModel {
  Routes routes;
  List<OrderList> orders;

  AllOrderTrackModel({this.routes, this.orders});

  AllOrderTrackModel.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = Routes.fromJson(json['routes']);
    }
    if (json['orders'] != null) {
      orders = <OrderList>[];
      json['orders'].forEach((v) {
        orders.add(new OrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.routes != null) {
      data['routes'] = this.routes.toJson();
    }
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Routes {
  double distance;
  String distanceText;
  String duration;
  int durationSec;
  String status;
  String driveMode;
  String encodedPolyline;

  Routes(
      {this.distance,
        this.distanceText,
        this.duration,
        this.durationSec,
        this.status,
        this.driveMode,
        this.encodedPolyline});

  Routes.fromJson(Map<String, dynamic> json) {
    distance =  json['distance'] != null ? json['distance'].toDouble() :  0.0;
    distanceText = json['distance_text'];
    duration = json['duration'];
    durationSec = json['duration_sec'];
    status = json['status'];
    driveMode = json['drive_mode'];
    encodedPolyline = json['encoded_polyline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['distance_text'] = this.distanceText;
    data['duration'] = this.duration;
    data['duration_sec'] = this.durationSec;
    data['status'] = this.status;
    data['drive_mode'] = this.driveMode;
    data['encoded_polyline'] = this.encodedPolyline;
    return data;
  }
}



class PickupCoordinates {
  String type;
  List<double> coordinates;

  PickupCoordinates({this.type, this.coordinates});

  PickupCoordinates.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}



