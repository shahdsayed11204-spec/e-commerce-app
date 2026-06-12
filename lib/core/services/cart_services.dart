import 'package:dio/dio.dart';
import 'package:untitled3/core/constants/cahce_key.dart'; // تأكدي من مسار الـ CacheKeys
import '../../features/cart/data/model/cartmodel.dart';
import '../constants/end_point.dart';
import '../network/api_error.dart';
import '../network/api_exceptions.dart';
import '../network/dio_helper.dart';

class CartServices {
  final DioClient dioClient = DioClient();

  Options _getOptions() {
    return Options(
      headers: {
        'token': CacheKeys.token ?? '',
      },
    );
  }

  /// ADD TO CART
  Future<dynamic> addToCart(String productId) async {
    try {
      final response = await dioClient.dio.post(
        addcart,
        data: {
          'productId': productId,
        },
        options: _getOptions(), // 🔑 تمرير التوكن
      );
      print(response.data);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: 'Something went wrong');
    }
  }

  /// GET CART
  Future<CartModel> getCart() async {
    try {
      final response = await dioClient.dio.get(
        getcart,
        options: _getOptions(),
      );

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
        options: _getOptions(), // 🔑 تمرير التوكن
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
        options: _getOptions(),
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: 'Something went wrong');
    }
  }
}