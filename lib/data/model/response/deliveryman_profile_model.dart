
class DeliveryManProfileModel {
  int id;
  String fName;
  String lName;
  String phone;
  String email;
  String identityNumber;
  String identityType;
  String identityImage;
  String image;
  String fcmToken;
  int zoneId;
  String createdAt;
  String updatedAt;
  int status;
  int active;
  int earning;
  int currentOrders;
  String type;
  String restaurantId;
  String applicationStatus;
  int orderCount;
  int assignedOrderCount;
  String fatherName;
  String code;
  bool isLaundryDm;
  int vehicleTypeId;
  int deliveredOrdersCount;
  int collectedOrdersCount;
  int beforeDeliveredOrdersCount;
  int beforePickedOrdersCount;
  List<Documents> documents;
  Zone zone;
  String suspensionLog;

  DeliveryManProfileModel(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.identityNumber,
        this.identityType,
        this.identityImage,
        this.image,
        this.fcmToken,
        this.zoneId,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.active,
        this.earning,
        this.currentOrders,
        this.type,
        this.restaurantId,
        this.applicationStatus,
        this.orderCount,
        this.assignedOrderCount,
        this.fatherName,
        this.code,
        this.isLaundryDm,
        this.vehicleTypeId,
        this.deliveredOrdersCount,
        this.collectedOrdersCount,
        this.beforeDeliveredOrdersCount,
        this.beforePickedOrdersCount,
        this.documents,
        this.zone,
        this.suspensionLog});

  DeliveryManProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    identityNumber = json['identity_number'];
    identityType = json['identity_type'];
    identityImage = json['identity_image'];
    image = json['image'];
    fcmToken = json['fcm_token'];
    zoneId = json['zone_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = int.tryParse(json['status'].toString());
    active = json['active'];
    earning = json['earning'];
    currentOrders = json['current_orders'];
    type = json['type'];
    restaurantId = json['restaurant_id'];
    applicationStatus = json['application_status'];
    orderCount = json['order_count'];
    assignedOrderCount = json['assigned_order_count'];
    fatherName = json['father_name'];
    code = json['code'];
    isLaundryDm = json['is_laundry_dm'];
    vehicleTypeId = json['vehicle_type_id'];
    deliveredOrdersCount = json['delivered_orders_count'];
    collectedOrdersCount = json['collected_orders_count'];
    beforeDeliveredOrdersCount = json['before_delivered_orders_count'];
    beforePickedOrdersCount = json['before_picked_orders_count'];

    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    zone = json['zone'] != null ? new Zone.fromJson(json['zone']) : null;
    suspensionLog = json['suspension_log'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['identity_number'] = this.identityNumber;
    data['identity_type'] = this.identityType;
    data['identity_image'] = this.identityImage;
    data['image'] = this.image;
    data['fcm_token'] = this.fcmToken;
    data['zone_id'] = this.zoneId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['active'] = this.active;
    data['earning'] = this.earning;
    data['current_orders'] = this.currentOrders;
    data['type'] = this.type;
    data['restaurant_id'] = this.restaurantId;
    data['application_status'] = this.applicationStatus;
    data['order_count'] = this.orderCount;
    data['assigned_order_count'] = this.assignedOrderCount;
    data['father_name'] = this.fatherName;
    data['code'] = this.code;
    data['is_laundry_dm'] = this.isLaundryDm;
    data['vehicle_type_id'] = this.vehicleTypeId;
    data['delivered_orders_count'] = this.deliveredOrdersCount;
    data['collected_orders_count'] = this.collectedOrdersCount;
    data['before_delivered_orders_count'] = this.beforeDeliveredOrdersCount;
    data['before_picked_orders_count'] = this.beforePickedOrdersCount;
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    if (this.zone != null) {
      data['zone'] = this.zone.toJson();
    }
    data['suspension_log'] = this.suspensionLog;
    return data;
  }
}

class Documents {
  int id;
  int deliveryManId;
  String type;
  String documentType;
  String data;
  List<String> files;
  String createdAt;
  String updatedAt;

  Documents(
      {this.id,
        this.deliveryManId,
        this.type,
        this.documentType,
        this.data,
        this.files,
        this.createdAt,
        this.updatedAt});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryManId = json['delivery_man_id'];
    type = json['type'];
    documentType = json['document_type'];
    data = json['data'];
    files = json['files'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delivery_man_id'] = this.deliveryManId;
    data['type'] = this.type;
    data['document_type'] = this.documentType;
    data['data'] = this.data;
    data['files'] = this.files;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Zone {
  int id;
  String name;
  int status;
  String createdAt;
  String updatedAt;
  String restaurantWiseTopic;
  String customerWiseTopic;
  String deliverymanWiseTopic;

  Zone(
      {this.id,
        this.name,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.restaurantWiseTopic,
        this.customerWiseTopic,
        this.deliverymanWiseTopic});

  Zone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = int.tryParse(json['status'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    restaurantWiseTopic = json['restaurant_wise_topic'];
    customerWiseTopic = json['customer_wise_topic'];
    deliverymanWiseTopic = json['deliveryman_wise_topic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['restaurant_wise_topic'] = this.restaurantWiseTopic;
    data['customer_wise_topic'] = this.customerWiseTopic;
    data['deliveryman_wise_topic'] = this.deliverymanWiseTopic;
    return data;
  }
}