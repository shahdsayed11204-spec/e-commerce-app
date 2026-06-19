import 'package:bloc/bloc.dart';
import 'package:untitled3/core/services/home_services.dart';
import 'package:untitled3/features/home/data/cubit/home_state.dart';
import 'package:untitled3/features/home/data/models/products/product_model.dart';

import '../../../../core/network/api_error.dart';
import '../models/categoris/categoris_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialStates());

  HomeServices homeServices = HomeServices();
  /// change

  int selectedIndex = 0;
  String selectedCategoryId = '';
  void changeCategory(index){
    selectedIndex=index;
    selectedCategoryId=categorisModel[index].sId??'No Categorise Yet';
    emit(HomeChangeCategoryStates());
  }

  /// get Categories
  List<CategorisModel> categorisModel = [];
  Future<void> getCategories() async {
    emit(HomeCategoriesLoadingStates());

    try {
      categorisModel = await homeServices.getcategories();
       if(categorisModel.isNotEmpty){
         selectedCategoryId=categorisModel[0].sId??'No Categorise Yet';
       }
      emit(HomeCategoriesSuccessStates(categorisModel));
    } catch (e) {
      if (e is ApiError) {
        emit(HomeCategoriesErrorStates(e.message));
      } else {
        emit(HomeCategoriesErrorStates('Something went wrong'));
      }
    }
  }
  /// get products
  List<ProductData> productmodel = [];
  Future<void> getProducts() async {
    emit(HomeProductsLoadingStates());
    try {
      productmodel = await homeServices.getproducts();
      emit(HomeProductsSuccessStates(productmodel));
    } catch (e) {
      if (e is ApiError) {
        emit(HomeProductsErrorStates(e.message));
      } else {
        emit(HomeProductsErrorStates('Something went wrong'));
      }
    }
  }
/// filtered products
  List<ProductData> get filteredProducts {
    if (selectedCategoryId.isEmpty) return productmodel;
    return productmodel.where((product) {
      return product.category?.id == selectedCategoryId;
    }).toList();
  }


/// get productsDetails

  ProductModel?productModel;
  Future<void> getProductsDetails() async {
    emit(HomeProductsDetailsLoadingStates());
    try {
      productModel = await homeServices.productsDetails();
      emit(HomeProductsDetailsSuccessStates(productModel!));
    } catch (e) {
      if (e is ApiError) {
        emit(HomeProductsDetailsErrorStates(e.message));
      } else {
        emit(HomeProductsDetailsErrorStates('Something went wrong'));
      }
    }
  }

  ProductData? getProductById(String id) {
    try {
      return productmodel.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}

