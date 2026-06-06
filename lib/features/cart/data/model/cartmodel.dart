class CartModel {
  String? status;
  int? numOfCartItems;
  CartData? data;

  CartModel({
    this.status,
    this.numOfCartItems,
    this.data,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    numOfCartItems = json['numOfCartItems'];

    data =
    json['data'] != null ? CartData.fromJson(json['data']) : null;
  }
}
class CartData {
  List<CartProduct>? products;
  int? totalCartPrice;

  CartData({
    this.products,
    this.totalCartPrice,
  });

  CartData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <CartProduct>[];

      json['products'].forEach((v) {
        products!.add(CartProduct.fromJson(v));
      });
    }

    totalCartPrice = json['totalCartPrice'];
  }
}
class CartProduct {
  String? id;
  int? count;
  Product? product;

  CartProduct({
    this.id,
    this.count,
    this.product,
  });

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    count = json['count'];

    product = json['product'] != null
        ? Product.fromJson(json['product'])
        : null;
  }
}
class Product {
  String? id;
  String? title;
  String? imageCover;
  int? price;
  String?description;

  Product({
    this.id,
    this.title,
    this.imageCover,
    this.price,
    this.description,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    imageCover = json['imageCover'];
    price = json['price'];
    description = json['description'];
  }
}