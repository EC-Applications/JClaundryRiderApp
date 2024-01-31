class PickOrderMapBody {
  List<double> pickupCoordinates;
  List<double> destinationCoordinates;

  PickOrderMapBody({this.pickupCoordinates, this.destinationCoordinates});

  PickOrderMapBody.fromJson(Map<String, dynamic> json) {
    pickupCoordinates = json['pickup_coordinates'].cast<double>();
    destinationCoordinates = json['destination_coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pickup_coordinates'] = this.pickupCoordinates;
    data['destination_coordinates'] = this.destinationCoordinates;
    return data;
  }
}