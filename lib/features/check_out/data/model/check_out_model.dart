class CheckOutModel{
  String? status;
  Data? data;

  CheckOutModel({this.status, this.data});

  CheckOutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? taxPrice;
  int? shippingPrice;
  int? totalOrderPrice;
  String? paymentMethodType;
  bool? isPaid;
  bool? isDelivered;
  String? sId;
  String? user;
  List<CartItems>? cartItems;
  ShippingAddress? shippingAddress;
  String? createdAt;
  String? updatedAt;
  int? id;
  int? iV;

  Data(
      {this.taxPrice,
        this.shippingPrice,
        this.totalOrderPrice,
        this.paymentMethodType,
        this.isPaid,
        this.isDelivered,
        this.sId,
        this.user,
        this.cartItems,
        this.shippingAddress,
        this.createdAt,
        this.updatedAt,
        this.id,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    taxPrice = json['taxPrice'];
    shippingPrice = json['shippingPrice'];
    totalOrderPrice = json['totalOrderPrice'];
    paymentMethodType = json['paymentMethodType'];
    isPaid = json['isPaid'];
    isDelivered = json['isDelivered'];
    sId = json['_id'];
    user = json['user'];
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    shippingAddress = json['shippingAddress'] != null
        ? new ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taxPrice'] = this.taxPrice;
    data['shippingPrice'] = this.shippingPrice;
    data['totalOrderPrice'] = this.totalOrderPrice;
    data['paymentMethodType'] = this.paymentMethodType;
    data['isPaid'] = this.isPaid;
    data['isDelivered'] = this.isDelivered;
    data['_id'] = this.sId;
    data['user'] = this.user;
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    if (this.shippingAddress != null) {
      data['shippingAddress'] = this.shippingAddress!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    data['__v'] = this.iV;
    return data;
  }
}

class CartItems {
  int? count;
  String? sId;
  String? product;
  int? price;

  CartItems({this.count, this.sId, this.product, this.price});

  CartItems.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    sId = json['_id'];
    product = json['product'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['_id'] = this.sId;
    data['product'] = this.product;
    data['price'] = this.price;
    return data;
  }
}

class ShippingAddress {
  String? details;
  String? phone;
  String? city;

  ShippingAddress({this.details, this.phone, this.city});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    details = json['details'];
    phone = json['phone'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['details'] = this.details;
    data['phone'] = this.phone;
    data['city'] = this.city;
    return data;
  }
}