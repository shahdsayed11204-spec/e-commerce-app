class ProductModel {
  int? results;
  Metadata? metadata;
  List<ProductData>? data;

  ProductModel({
    this.results,
    this.metadata,
    this.data,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    results = json['results'];

    metadata = json['metadata'] != null
        ? Metadata.fromJson(json['metadata'])
        : null;

    if (json['data'] != null) {
      data = <ProductData>[];

      json['data'].forEach((v) {
        data!.add(ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['results'] = results;

    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }

    if (this.data != null) {
      data['data'] =
          this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Metadata {
  int? currentPage;
  int? numberOfPages;
  int? limit;
  int? nextPage;

  Metadata({
    this.currentPage,
    this.numberOfPages,
    this.limit,
    this.nextPage,
  });

  Metadata.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    numberOfPages = json['numberOfPages'];
    limit = json['limit'];
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['currentPage'] = currentPage;
    data['numberOfPages'] = numberOfPages;
    data['limit'] = limit;
    data['nextPage'] = nextPage;

    return data;
  }
}

class ProductData {
  int? sold;
  List<String>? images;
  List<Subcategory>? subcategory;
  int? ratingsQuantity;
  String? id;
  String? title;
  String? slug;
  String? description;
  int? quantity;
  int? price;
  String? imageCover;
  Category? category;
  Category? brand;
  double? ratingsAverage;
  String? createdAt;
  String? updatedAt;
  int? priceAfterDiscount;
  List<String>? availableColors;

  ProductData({
    this.sold,
    this.images,
    this.subcategory,
    this.ratingsQuantity,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
    this.createdAt,
    this.updatedAt,
    this.priceAfterDiscount,
    this.availableColors,
  });

  ProductData.fromJson(Map<String, dynamic> json) {
    sold = json['sold'];

    images = json['images'] != null
        ? List<String>.from(json['images'])
        : [];

    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];

      json['subcategory'].forEach((v) {
        subcategory!.add(Subcategory.fromJson(v));
      });
    }

    ratingsQuantity = json['ratingsQuantity'];

    id = json['_id'];

    title = json['title'];

    slug = json['slug'];

    description = json['description'];

    quantity = json['quantity'];

    price = json['price'];

    imageCover = json['imageCover'];

    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;

    brand = json['brand'] != null
        ? Category.fromJson(json['brand'])
        : null;

    ratingsAverage =
        (json['ratingsAverage'] as num?)
            ?.toDouble();

    createdAt = json['createdAt'];

    updatedAt = json['updatedAt'];

    priceAfterDiscount =
    json['priceAfterDiscount'];

    availableColors =
    json['availableColors'] != null
        ? List<String>.from(
      json['availableColors'],
    )
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['sold'] = sold;

    data['images'] = images;

    if (subcategory != null) {
      data['subcategory'] =
          subcategory!
              .map((v) => v.toJson())
              .toList();
    }

    data['ratingsQuantity'] =
        ratingsQuantity;

    data['_id'] = id;

    data['title'] = title;

    data['slug'] = slug;

    data['description'] = description;

    data['quantity'] = quantity;

    data['price'] = price;

    data['imageCover'] = imageCover;

    if (category != null) {
      data['category'] = category!.toJson();
    }

    if (brand != null) {
      data['brand'] = brand!.toJson();
    }

    data['ratingsAverage'] =
        ratingsAverage;

    data['createdAt'] = createdAt;

    data['updatedAt'] = updatedAt;

    data['priceAfterDiscount'] =
        priceAfterDiscount;

    data['availableColors'] =
        availableColors;

    return data;
  }
}

class Subcategory {
  String? id;
  String? name;
  String? slug;
  String? category;

  Subcategory({
    this.id,
    this.name,
    this.slug,
    this.category,
  });

  Subcategory.fromJson(
      Map<String, dynamic> json) {
    id = json['_id'];

    name = json['name'];

    slug = json['slug'];

    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['_id'] = id;

    data['name'] = name;

    data['slug'] = slug;

    data['category'] = category;

    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? slug;
  String? image;

  Category({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  Category.fromJson(
      Map<String, dynamic> json) {
    id = json['_id'];

    name = json['name'];

    slug = json['slug'];

    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['_id'] = id;

    data['name'] = name;

    data['slug'] = slug;

    data['image'] = image;

    return data;
  }
}