import 'package:untitled3/features/home/data/models/categoris/categoris_model.dart';
import 'package:untitled3/features/home/data/models/products/product_model.dart';

abstract class HomeStates {}

class HomeInitialStates extends HomeStates {}

/// categorise
class HomeChangeCategoryStates extends HomeStates {}

class HomeCategoriesLoadingStates extends HomeStates {}

class HomeCategoriesSuccessStates extends HomeStates {
  final List<CategorisModel> categorisModel;

  HomeCategoriesSuccessStates(this.categorisModel);
}

class HomeCategoriesErrorStates extends HomeStates {
  final String message;

  HomeCategoriesErrorStates(this.message);
}
/// products
class HomeProductsLoadingStates extends HomeStates {}

class HomeProductsSuccessStates extends HomeStates {
  final List<ProductData> productData;

  HomeProductsSuccessStates(this.productData);

}

class HomeProductsErrorStates extends HomeStates {
  final String message;

  HomeProductsErrorStates(this.message);
}
/// productsDetails
class HomeProductsDetailsLoadingStates extends HomeStates {}

class HomeProductsDetailsSuccessStates extends HomeStates {
  final ProductModel productModel;

  HomeProductsDetailsSuccessStates(this.productModel);
}

class HomeProductsDetailsErrorStates extends HomeStates {
  final String message;

  HomeProductsDetailsErrorStates(this.message);
}