import 'package:dio/dio.dart';
import 'package:untitled3/core/network/api_error.dart';
import 'package:untitled3/features/home/data/models/categoris/categoris_model.dart';
import 'package:untitled3/features/home/data/models/products/product_model.dart';

import '../constants/end_point.dart';
import '../network/api_exceptions.dart';
import '../network/dio_helper.dart';

class HomeServices {
  DioClient dioClient=DioClient();

  HomeServices();
  /// get categorise
  Future<List<CategorisModel>> getcategories() async {
    try {
      final response = await dioClient.dio.get(categories);
      return List<CategorisModel>.from(
        response.data['data'].map((item)=>CategorisModel.fromJson(item)),
      );
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(
        message: 'Something went wrong',
      );
    }
  }

  /// get products
  Future<List<ProductData>> getproducts() async {
    final response = await dioClient.dio.get(products);
    return List<ProductData>.from(
      response.data['data'].map(
            (item) => ProductData.fromJson(item),
      ),
    );
  }

  /// get productsDetails
  Future<ProductModel> productsDetails() async {
    final response = await dioClient.dio.get(products);
    return ProductModel.fromJson(
     response.data,
    );
  }
}
