class LaundryServiceModel {
  int id;
  String icon;
  String name;
  int status;
  String createdAt;

  LaundryServiceModel({this.id, this.icon, this.name, this.status, this.createdAt});

  LaundryServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    name = json['name'];
    status = json['status']?.runtimeType == String ? int.parse(json['status']) : json['status'];
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


