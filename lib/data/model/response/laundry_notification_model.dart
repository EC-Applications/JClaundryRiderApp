class PaginationLaundryNotificationModel {
  int totalSize;
  String limit;
  String offset;
  List<LaundryNotificationModel> data;

  PaginationLaundryNotificationModel(
      {this.totalSize, this.limit, this.offset, this.data});

  PaginationLaundryNotificationModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = <LaundryNotificationModel>[];
      json['data'].forEach((v) {
        data.add(new LaundryNotificationModel.fromJson(v));
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

class LaundryNotificationModel {
  String key;
  String value;
  int orderId;
  String status;
  String time;

  LaundryNotificationModel(
      {this.key, this.value, this.orderId, this.status, this.time});

  LaundryNotificationModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    orderId = json['order_id'];
    status = json['status'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    data['time'] = this.time;
    return data;
  }
}