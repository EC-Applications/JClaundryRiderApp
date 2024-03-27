class OrderListModel {
  int totalSize;
  String limit;
  String offset;
  List<OrderList> data;


  OrderListModel(
      {this.totalSize, this.limit, this.offset, this.data});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = <OrderList>[];
      json['data'].forEach((v) {
        data.add(new OrderList.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class OrderList {
  int id;
  String deliverymanId;
  String orderStatus;
  String deferredAt;
  String deferredReason;

  double orderAmount;
  String paymentStatus;
  String paymentMethod;
  String transactionReference;
  PickupCoordinates pickupCoordinates;
  PickupAddress pickupAddress;
  PickupCoordinates destinationCoordinates;
  PickupAddress destinationAddress;
  String deliveryTime;
  String deliveryCharge;
  int barCode;
  double taxAmount;
  double discountAmount;
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
  LaundryDeliveryType laundryDeliveryType;

  OrderList(
      {this.id,
        this.deliverymanId,
        this.orderStatus,
           this.deferredAt,
      this.deferredReason,

        this.orderAmount,
        this.paymentStatus,
        this.paymentMethod,
        this.transactionReference,
        this.pickupCoordinates,
        this.pickupAddress,
        this.destinationCoordinates,
        this.destinationAddress,
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
        this.laundryDeliveryType
      });

  OrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliverymanId = json['deliveryman_id']?.toString();
    orderStatus = json['order_status'];
    deferredAt = json['deferred_at'];
    deferredReason = json['deferred_reason'];
    orderAmount = json['order_amount'] != null
        ? json['order_amount'].toDouble()
        : 0.0;
    paymentStatus = json['payment_status'];
    paymentMethod = json['payment_method'];
    transactionReference = json['transaction_reference'];
    pickupCoordinates = json['pickup_coordinates'] != null
        ? new PickupCoordinates.fromJson(json['pickup_coordinates'])
        : null;
    pickupAddress = json['pickup_address'] != null
        ? new PickupAddress.fromJson(json['pickup_address'])
        : null;
    destinationCoordinates = json['destination_coordinates'] != null
        ? new PickupCoordinates.fromJson(json['destination_coordinates'])
        : null;
    destinationAddress = json['destination_address'] != null
        ? new PickupAddress.fromJson(json['destination_address'])
        : null;
    laundryDeliveryType = json['laundry_delivery_type'] != null
        ? new LaundryDeliveryType.fromJson(json['laundry_delivery_type'])
        : null;
    deliveryTime = json['delivery_time'];
    deliveryCharge = json['delivery_charge'];
    barCode = json['bar_code'];
    taxAmount = json['tax_amount'] != null ? json['tax_amount'].toDouble() : 0.0;
    discountAmount = json['discount_amount'] != null
        ? json['discount_amount'].toDouble()
        : 0.0;
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

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deliveryman_id'] = this.deliverymanId;
    data['order_status'] = this.orderStatus;
    data['deferred_at'] = this.deferredAt;
    data['deferred_reason'] = this.deferredReason;
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
    data['laundry_delivery_type'] = this.laundryDeliveryType;
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

class PickupAddress {
  int floor;
  int road;
  int house;
  String address;
  String contactPersonName;
  String contactPersonNumber;

  PickupAddress(
      {this.floor,
        this.road,
        this.house,
        this.address,
        this.contactPersonName,
        this.contactPersonNumber});

  PickupAddress.fromJson(Map<String, dynamic> json) {
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




