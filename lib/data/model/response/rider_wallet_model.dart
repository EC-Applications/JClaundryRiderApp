class RiderWalletModel {
  int cashCollection;
  int totalBalance;
  int deliveryMan;

  RiderWalletModel({this.cashCollection, this.totalBalance, this.deliveryMan});

  RiderWalletModel.fromJson(Map<String, dynamic> json) {
    cashCollection = json['cashCollection'];
    totalBalance = json['totalBalance'];
    deliveryMan = json['deliveryMan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cashCollection'] = this.cashCollection;
    data['totalBalance'] = this.totalBalance;
    data['deliveryMan'] = this.deliveryMan;
    return data;
  }
}