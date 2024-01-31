
class LaundryServiceItemModel {
  int totalSize;
  String limit;
  String offset;
  List<Data> data;


  LaundryServiceItemModel(
      {this.totalSize, this.limit, this.offset, this.data});

  LaundryServiceItemModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  String icon;
  String name;
  double price;
  int status;
  String createdAt;

  Data(
      {this.id, this.icon, this.name, this.price, this.status, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    name = json['name'];
    price = json['price'].toDouble();
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['price'] = this.price;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}