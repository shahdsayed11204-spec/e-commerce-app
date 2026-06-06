import 'package:dio/dio.dart';

import '../../features/cart/data/model/cartmodel.dart';
import '../constants/end_point.dart';
import '../network/api_error.dart';
import '../network/api_exceptions.dart';
import '../network/dio_helper.dart';

class CartServices {
  DioClient dioClient = DioClient();

  /// ADD TO CART
  /// ADD TO CART
  Future<dynamic> addToCart(String id) async { // تغيير الـ Return لـ dynamic
    try {
      final response = await dioClient.dio.post(
        addcart,
        data: {
          'productId': id, // متأكدين إنها productId
        },
      );
      return response.data; // رجعي الداتا الخام بدون ما تمرريها للموديل هنا
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: 'Something went wrong');
    }
  }

  /// GET CART
  Future<CartModel> getCart() async {
    try {
      final response = await dioClient.dio.get(getcart);

      return CartModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: 'Something went wrong');
    }
  }

  /// UPDATE CART (count)
  Future<dynamic> updateCart(String cartItemId, int count) async {
    try {
      final response = await dioClient.dio.put(
        '$updatacart/$cartItemId',
        data: {
          'count': count,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: 'Something went wrong');
    }
  }

  /// DELETE FROM CART
  Future<dynamic> deleteCart(String cartItemId) async {
    try {
      final response = await dioClient.dio.delete(
        '$delcart/$cartItemId',
      );
      response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: 'Something went wrong');
    }
  }
}