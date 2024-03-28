// class LaundryOrderDetailsModel {
//   int totalSize;
//   int limit;
//   int offset;
//   LaundryOrderDetails data;


//   LaundryOrderDetailsModel(
//       {this.totalSize, this.limit, this.offset, this.data});

//   LaundryOrderDetailsModel.fromJson(Map<String, dynamic> json) {
//     totalSize = json['total_size'];
//     limit = json['limit'];
//     offset = json['offset'];
//     data = json['data'] != null ? new LaundryOrderDetails.fromJson(json['data']) : null;

//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['total_size'] = this.totalSize;
//     data['limit'] = this.limit;
//     data['offset'] = this.offset;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }

//     return data;
//   }
// }


class LaundryOrderDetails {
  int id;
  int deliverymanId;
  String orderStatus;
  double orderAmount;
  String paymentStatus;
  String paymentMethod;
  String transactionReference;
  PickupCoordinates pickupCoordinates;
  LaundryPickupAddress pickupAddress;
  PickupCoordinates destinationCoordinates;
  LaundryPickupAddress destinationAddress;
  LaundryDeliveryType laundryDeliveryType;
  String deliveryTime;
  String deliveryCharge;
  int barCode;
  int taxAmount;
  int discountAmount;
  String distance;
  String note;
  String pickupScheduleAt;
  String deliveryScheduleAt;
  String pending;
  String confirmed;
  String outForPickup;
  String pickedUp;
  String arrived;
  String processing;
  String readyForDelivery;
  String outForDelivery;
  String delivered;
  String cancelled;
  String createdAt;
  List<Details> details;
  int detailsCount;

  LaundryOrderDetails(
      {this.id,
        this.deliverymanId,
        this.orderStatus,
        this.orderAmount,
        this.paymentStatus,
        this.paymentMethod,
        this.transactionReference,
        this.pickupCoordinates,
        this.pickupAddress,
        this.destinationCoordinates,
        this.destinationAddress,
        this.laundryDeliveryType,
        this.deliveryTime,
        this.deliveryCharge,
        this.barCode,
        this.taxAmount,
        this.discountAmount,
        this.distance,
        this.note,
        this.pickupScheduleAt,
        this.deliveryScheduleAt,
        this.pending,
        this.confirmed,
        this.outForPickup,
        this.pickedUp,
        this.arrived,
        this.processing,
        this.readyForDelivery,
        this.outForDelivery,
        this.delivered,
        this.cancelled,
        this.createdAt,
        this.details,
        this.detailsCount});

  LaundryOrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliverymanId = json['deliveryman_id'];
    orderStatus = json['order_status'];
    orderAmount = json['order_amount'] != null ? json['order_amount'].toDouble() : 0;
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    transactionReference = json['transaction_reference'];
    pickupCoordinates = json['pickup_coordinates'] != null
        ? new PickupCoordinates.fromJson(json['pickup_coordinates'])
        : null;
    pickupAddress = json['pickup_address'] != null
        ? new LaundryPickupAddress.fromJson(json['pickup_address'])
        : null;
    destinationCoordinates = json['destination_coordinates'] != null
        ? new PickupCoordinates.fromJson(json['destination_coordinates'])
        : null;
    destinationAddress = json['destination_address'] != null
        ? new LaundryPickupAddress.fromJson(json['destination_address'])
        : null;
    laundryDeliveryType = json['laundry_delivery_type'] != null
        ? new LaundryDeliveryType.fromJson(json['laundry_delivery_type'])
        : null;
    deliveryTime = json['delivery_time'];
    deliveryCharge = json['delivery_charge'];
    barCode = json['bar_code'];
    taxAmount = json['tax_amount'];
    discountAmount = json['discount_amount'];
    distance = json['distance'];
    note = json['note'];
    pickupScheduleAt = json['pickup_schedule_at'];
    deliveryScheduleAt = json['delivery_schedule_at'];
    pending = json['pending'];
    confirmed = json['confirmed'];
    outForPickup = json['out_for_pickup'];
    pickedUp = json['picked_up'];
    arrived = json['arrived'];
    processing = json['processing'];
    readyForDelivery = json['ready_for_delivery'];
    outForDelivery = json['out_for_delivery'];
    delivered = json['delivered'];
    cancelled = json['cancelled'];
    createdAt = json['created_at'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    detailsCount = json['details_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deliveryman_id'] = this.deliverymanId;
    data['order_status'] = this.orderStatus;
    data['order_amount'] = this.orderAmount;
    data['payment_status'] = this.paymentStatus;
    data['payment_method'] = this.paymentMethod;
    data['transaction_reference'] = this.transactionReference;
    if (this.pickupCoordinates != null) {
      data['pickup_coordinates'] = this.pickupCoordinates.toJson();
    }
    if (this.pickupAddress != null) {
      data['pickup_address'] = this.pickupAddress.toJson();
    }
    if (this.destinationCoordinates != null) {
      data['destination_coordinates'] = this.destinationCoordinates.toJson();
    }
    if (this.destinationAddress != null) {
      data['destination_address'] = this.destinationAddress.toJson();
    }
    if (this.laundryDeliveryType != null) {
      data['laundry_delivery_type'] = this.laundryDeliveryType.toJson();
    }
    data['delivery_time'] = this.deliveryTime;
    data['delivery_charge'] = this.deliveryCharge;
    data['bar_code'] = this.barCode;
    data['tax_amount'] = this.taxAmount;
    data['discount_amount'] = this.discountAmount;
    data['distance'] = this.distance;
    data['note'] = this.note;
    data['pickup_schedule_at'] = this.pickupScheduleAt;
    data['delivery_schedule_at'] = this.deliveryScheduleAt;
    data['pending'] = this.pending;
    data['confirmed'] = this.confirmed;
    data['out_for_pickup'] = this.outForPickup;
    data['picked_up'] = this.pickedUp;
    data['arrived'] = this.arrived;
    data['processing'] = this.processing;
    data['ready_for_delivery'] = this.readyForDelivery;
    data['out_for_delivery'] = this.outForDelivery;
    data['delivered'] = this.delivered;
    data['cancelled'] = this.cancelled;
    data['created_at'] = this.createdAt;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['details_count'] = this.detailsCount;
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

class LaundryPickupAddress {
  int floor;
  int road;
  int house;
  String address;
  String contactPersonName;
  String contactPersonNumber;

  LaundryPickupAddress(
      {this.floor,
        this.road,
        this.house,
        this.address,
        this.contactPersonName,
        this.contactPersonNumber});

  LaundryPickupAddress.fromJson(Map<String, dynamic> json) {
    floor = json['floor'];
    road = json['road'];
    house = json['house'];
    address = json['address'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['floor'] = this.floor;
    data['road'] = this.road;
    data['house'] = this.house;
    data['address'] = this.address;
    data['contact_person_name'] = this.contactPersonName;
    data['contact_person_number'] = this.contactPersonNumber;
    return data;
  }
}

class LaundryDeliveryType {
  int id;
  String title;
  int duration;
  int charge;
  int status;

  LaundryDeliveryType(
      {this.id, this.title, this.duration, this.charge, this.status});

  LaundryDeliveryType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    duration = json['duration'];
    charge = json['charge'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['duration'] = this.duration;
    data['charge'] = this.charge;
    data['status'] = this.status;
    return data;
  }
}

class Details {
  int id;
  Service service;
  LaundryItem laundryItem;
  int quantity;
  double price;
  String barCode;
  String processing;
  String processed;
  String createdAt;

  Details(
      {this.id,
        this.service,
        this.laundryItem,
        this.quantity,
        this.price,
        this.barCode,
        this.processing,
        this.processed,
        this.createdAt});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    laundryItem = json['laundry_item'] != null
        ? new LaundryItem.fromJson(json['laundry_item'])
        : null;
    quantity = json['quantity'];
    price = json['price'] != null ? json['price'].toDouble() : 0;
    barCode = json['bar_code'];
    processing = json['processing'];
    processed = json['processed'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.service != null) {
      data['service'] = this.service.toJson();
    }
    if (this.laundryItem != null) {
      data['laundry_item'] = this.laundryItem.toJson();
    }
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['bar_code'] = this.barCode;
    data['processing'] = this.processing;
    data['processed'] = this.processed;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Service {
  int id;
  String icon;
  String name;
  int status;
  String createdAt;

  Service({this.id, this.icon, this.name, this.status, this.createdAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}


class Addons{
  int id;
  String name;
  double price;
  int qty;

  Addons({this.id,
      this.name,
      this.price,
      this.qty
      });

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['addon_id'];
    name = json['addon_name'];
    price = double.parse(json['price']);
    qty = json['qty']; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['qty'] = this.qty;
    return data;
  }

  void removeAt(int k) {}
}



class LaundryItem {
  int id;
  String icon;
  String name;
  double price;
  int status;
  String createdAt;
  List<Addons> addons;

  LaundryItem(
      {this.id, this.icon, this.name, this.price, this.status, this.createdAt, this.addons});

  LaundryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    name = json['name'];
    price = json['price'];
    status = json['status'];
    createdAt = json['created_at'];
     if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons.add(new Addons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['price'] = this.price;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    if (this.addons != null) {
      data['addons'] = this.addons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


