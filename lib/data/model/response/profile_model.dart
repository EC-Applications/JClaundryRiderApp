class ProfileModel {
  int id;
  String fName;
  String lName;
  String fatherName;
  String phone;
  String email;
  String identityNumber;
  String identityType;
  String identityImage;
  String image;
  String fcmToken;
  int zoneId;
  int active;
  double avgRating;
  int ratingCount;
  int memberSinceDays;
  int orderCount;
  int todaysOrderCount;
  int thisWeekOrderCount;
  double cashInHands;
  int earnings;
  String type;
  double balance;
  double todaysEarning;
  double thisWeekEarning;
  double thisMonthEarning;
  String createdAt;
  String updatedAt;
  List<Documents> documents;
  Zone zone;

  ProfileModel(
      {this.id,
        this.fName,
        this.lName,
        this.fatherName,
        this.phone,
        this.email,
        this.identityNumber,
        this.identityType,
        this.identityImage,
        this.image,
        this.fcmToken,
        this.zoneId,
        this.active,
        this.avgRating,
        this.memberSinceDays,
        this.orderCount,
        this.todaysOrderCount,
        this.thisWeekOrderCount,
        this.cashInHands,
        this.ratingCount,
        this.createdAt,
        this.updatedAt,
        this.earnings,
        this.type,
        this.balance,
        this.todaysEarning,
        this.thisWeekEarning,
        this.thisMonthEarning,
        this.documents,
        this.zone,
      });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    fatherName = json['father_name'];
    phone = json['phone'];
    email = json['email'];
    identityNumber = json['identity_number'];
    identityType = json['identity_type'];
    identityImage = json['identity_image'];
    image = json['image'];
    fcmToken = json['fcm_token'];
    zoneId = json['zone_id'];
    active = json['active'];
    avgRating = json['avg_rating'].toDouble();
    ratingCount = json['rating_count'];
    memberSinceDays = json['member_since_days'];
    orderCount = json['order_count'];
    todaysOrderCount = json['todays_order_count'];
    thisWeekOrderCount = json['this_week_order_count'];
    cashInHands = json['cash_in_hands'].toDouble();
    earnings = json['earning'];
    type = json['type'];
    balance = json['balance'].toDouble();
    todaysEarning = json['todays_earning'].toDouble();
    thisWeekEarning = json['this_week_earning'].toDouble();
    thisMonthEarning = json['this_month_earning'].toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    documents = <Documents>[];
    if (json['documents'] != null) {
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
    zone = json['zone'] != null ? new Zone.fromJson(json['zone']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['father_name'] = this.fatherName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['identity_number'] = this.identityNumber;
    data['identity_type'] = this.identityType;
    data['identity_image'] = this.identityImage;
    data['image'] = this.image;
    data['fcm_token'] = this.fcmToken;
    data['zone_id'] = this.zoneId;
    data['active'] = this.active;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['member_since_days'] = this.memberSinceDays;
    data['order_count'] = this.orderCount;
    data['todays_order_count'] = this.todaysOrderCount;
    data['this_week_order_count'] = this.thisWeekOrderCount;
    data['cash_in_hands'] = this.cashInHands;
    data['earning'] = this.earnings;
    data['balance'] = this.balance;
    data['type'] = this.type;
    data['todays_earning'] = this.todaysEarning;
    data['this_week_earning'] = this.thisWeekEarning;
    data['this_month_earning'] = this.thisMonthEarning;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    if (this.zone != null) {
      data['zone'] = this.zone.toJson();
    }
    return data;
  }
}

class Zone {
  int id;
  String name;

  Zone({this.id, this.name});

  Zone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Documents {
  int id;
  String type;
  String documentType;
  String data;
  List<String> files;
  String createdAt;
  String updatedAt;

  Documents({
    this.id,
    this.type,
    this.documentType,
    this.data,
    this.files,
    this.createdAt,
    this.updatedAt,
  });

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['type'] = this.type;
    data['document_type'] = this.documentType;
    data['data'] = this.data;
    data['files'] = this.files;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}