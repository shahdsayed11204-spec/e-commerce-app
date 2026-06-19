class FavoriteModel {
  final String status;
  final int count;
  final List<Product> data;

  FavoriteModel({
    required this.status,
    required this.count,
    required this.data,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      status: json['status'],
      count: json['count'],
      data: List<Product>.from(
        json['data'].map((e) => Product.fromJson(e)),
      ),
    );
  }
}

class Product {
  final String id;
  final String title;
  final String imageCover;
  final int price;

  Product({
    required this.id,
    required this.title,
    required this.imageCover,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      title: json['title'],
      imageCover: json['imageCover'],
      price: json['price'],
    );
  }
}