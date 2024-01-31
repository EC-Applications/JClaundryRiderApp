class Cart {
  int servicesId;
  List<LaundryItems> items;

  Cart({this.servicesId, this.items});

  Cart.fromJson(Map<String, dynamic> json) {
    servicesId = json['services_id'];
    if (json['items'] != null) {
      items = <LaundryItems>[];
      json['items'].forEach((v) {
        items.add(new LaundryItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['services_id'] = this.servicesId;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LaundryItems {
  int laundryItemId;
  int quantity;
  double price;
  int detailsId;
  String name;

  LaundryItems({this.laundryItemId, this.quantity, this.price, this.detailsId, this.name});

  LaundryItems.fromJson(Map<String, dynamic> json) {
    laundryItemId = json['laundry_item_id'];
    quantity = json['quantity'];
    price = json['price'].toDouble();
    detailsId = json['details_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['laundry_item_id'] = this.laundryItemId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['details_id'] = this.detailsId;
    data['name'] = this.name;
    return data;
  }
}