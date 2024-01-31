
class LaundryPlaceOrderBody {
  String orderId;
  String token;
  List<Cart> cart;


  LaundryPlaceOrderBody(
      {
        this.orderId,
        this.token,
        this.cart,

      });

  LaundryPlaceOrderBody.fromJson(Map<String, dynamic> json) {

    orderId = json['order_id'];
    token = json['token'];

    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart.add(new Cart.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['order_id'] = this.orderId;
    data['token'] = this.token;
    if (this.cart != null) {
      data['cart'] = this.cart.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LaundryPickupAddressModel {
  int floor;
  int road;
  int house;
  String address;
  String contactPersonName;
  String contactPersonNumber;

  LaundryPickupAddressModel(
      {this.floor,
        this.road,
        this.house,
        this.address,
        this.contactPersonName,
        this.contactPersonNumber});

  LaundryPickupAddressModel.fromJson(Map<String, dynamic> json) {
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

class Cart {
  int servicesId;
  List<LaundryItemList> items;

  Cart({this.servicesId, this.items});

  Cart.fromJson(Map<String, dynamic> json) {
    servicesId = json['services_id'];
    if (json['items'] != null) {
      items = <LaundryItemList>[];
      json['items'].forEach((v) {
        items.add(new LaundryItemList.fromJson(v));
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

class LaundryItemList {
  int laundryItemId;
  int quantity;
  double price;
  int detailsId;
  String name;

  LaundryItemList({this.laundryItemId, this.quantity, this.price, this.detailsId, this.name});

  LaundryItemList.fromJson(Map<String, dynamic> json) {
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