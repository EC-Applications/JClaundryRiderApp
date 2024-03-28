

class LaundryServiceItemModel {
  int totalSize;
  String limit;
  String offset;
  List<Data> data;
  Campaign campaign;


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
    if ((json['campain'] as List<dynamic>).length != 0) {
      campaign = Campaign();
        campaign = Campaign.fromJson(json['campain'][0]);
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
  int laundryItemCategoryId;
  num price;
  num ePrice;
  int status;
  String createdAt;
  List<Addons> addons;	

  Data(
      {this.id,
      this.icon,
      this.name,
      this.laundryItemCategoryId,
      this.price,
      this.ePrice,
      this.status,
      this.createdAt,
      this.addons});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    name = json['name'];
    laundryItemCategoryId = json['laundry_item_category_id'];
    price =  num.parse(json['services'][0]['pivot']['price']);
    ePrice = num.parse(json['services'][0]['pivot']['e_price']);
    status = json['status'];
    createdAt = json['created_at'];
     if (json['addons'] != null) {
      addons = <Addons>[];
      json['addons'].forEach((v) {
        addons.add(new Addons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['laundry_item_category_id'] = this.laundryItemCategoryId;
    data['price'] = this.price;
    data['e_price'] = this.ePrice;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['addons'] = this.addons;
    return data;
  }
}

class Campaign{
  int id;
  String title;
  String image;
  String start_date;
  String end_date;
  String start_time;
  String end_time;
  num price;
  num tax;
  String tax_type;
  int discount;
  String discount_type;

  Campaign(
      {this.id,
      this.title,
      this.image,
      this.price,
      this.start_date,
      this.end_date,
      this.start_time,
      this.end_time,
      this.tax,
      this.tax_type,
      this.discount,
      this.discount_type});

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    start_time = json['start_time'];
    end_time = json['end_time'];
    tax = json['tax'];
    tax_type = json['tax_type'];
    discount = json['discount'];
    discount_type = json['discount_type'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['price'] = this.price;
    data['start_date'] = this.start_date;
    data['end_date'] = this.end_date;
    data['start_time'] = this.start_time;
    data['end_time'] = this.end_time;
    data['tax'] = this.tax;
    data['tax_type'] = this.tax_type;
    data['discount'] = this.discount;
    data['discount_type'] = this.discount_type;
    return data;
  }
}

class Addons{
  int id;
  String name;
  String price;


  Addons(
      {this.id,
      this.name,
      this.price
      });

  Addons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price']; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}



