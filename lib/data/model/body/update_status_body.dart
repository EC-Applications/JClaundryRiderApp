class UpdateStatusBody {
  String token;
  String orderId;
  String status;
  String cancelReason;
  String method = 'PUT';

  UpdateStatusBody({this.token, this.orderId, this.status, this.cancelReason});

  UpdateStatusBody.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    orderId = json['order_id'];
    status = json['status'];
    method = json['_method'];
    cancelReason = json['cancellation_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    data['_method'] = this.method;
    data['cancellation_reason'] = this.cancelReason;
    return data;
  }
}
