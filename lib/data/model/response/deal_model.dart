import 'package:efood_multivendor_driver/data/model/response/order_details_model.dart';

class DealModel {
  int id;
  int restaurantId;
  String title;
  String shortDescription;
  double price;
  String image;
  String startAt;
  String endAt;
  List<Options> options;
  int status;
  String createdAt;
  String updatedAt;
  int quantity;

  DealModel(
      {this.id,
        this.restaurantId,
        this.title,
        this.shortDescription,
        this.price,
        this.image,
        this.startAt,
        this.endAt,
        this.options,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.quantity,
      });

  DealModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    title = json['title'];
    shortDescription = json['short_description'];
    price = json['price'].toDouble();
    image = json['image'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['title'] = this.title;
    data['short_description'] = this.shortDescription;
    data['price'] = this.price;
    data['image'] = this.image;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Options {
  List<Items> items;
  String title;
  List<String> addonIds;
  List<AddOns> addons;

  Options({this.items, this.title, this.addonIds, this.addons});

  Options.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    title = json['title'];
    addonIds = json['addon_ids'] != null ? json['addon_ids'].cast<String>() : [];
    addons = <AddOns>[];
    if (json['addons'] != null) {
      addons = <AddOns>[];
      json['addons'].forEach((v) {
        addons.add(new AddOns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['addon_ids'] = this.addonIds;
    if (this.addons != null) {
      data['addons'] = this.addons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int id;
  String name;

  Items({this.id, this.name});

  Items.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
