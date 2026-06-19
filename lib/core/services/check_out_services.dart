import 'package:dio/dio.dart';
import 'package:untitled3/core/network/api_error.dart';
import 'package:untitled3/core/network/api_exceptions.dart';
import 'package:untitled3/core/network/dio_helper.dart';
import 'package:untitled3/features/check_out/data/model/check_out_model.dart';

class CheckOutServices {

  DioClient dioClient = DioClient();
/// GET CART DETAILS
  Future<Response> getCartDetails( String token) async {
    try {
      final response = await dioClient.dio.get(
        '/cart',
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );
      print(response.data);
      return response;

    } on DioException catch (e) {
      ApiExceptions.handleError(e);
      rethrow;
    } catch (e) {
      throw ApiError(message: 'Something went wrong');
    }
  }

  /// CREATE CASH ORDER
  Future<CheckOutModel?> createCashOrder(
     String cartId,
     Map<String, dynamic> shippingAddress,
     String token,
  )
  async {
    try {
      final response= await dioClient.dio.post('/orders/$cartId',data: {
        'shippingAddress':shippingAddress
      },
        options: Options(
          headers: {
            'token': token,
          },
        ),
      );
      CheckOutModel checkOutModel=CheckOutModel.fromJson(response.data);
      return checkOutModel;
    }on DioException catch(e){
      ApiExceptions.handleError(e);
    }
    catch (e) {
      throw ApiError(message: 'Something went wrong');

    }
  }

  /// CREATE CREDIT ORDER
 Future<String?>createVisaOrder({
   required String cartId,
   required Map<String, dynamic> shippingAddress,
   required String token,
 })async{
   try{
     final response= await dioClient.dio.post('/orders/checkout-session/$cartId',data: {
       'shippingAddress':shippingAddress
     },
       queryParameters: {
         'url': 'https://ecommerce.routemisr.com',
       },
       options: Options(
         headers: {
           'token': token,
         },
       ),
     );
     if (response.data['status'] == 'success') {
       return response.data['session']['url'];
     }
   } on DioException catch (e) {
     ApiExceptions.handleError(e);
     return null;
   } catch (e) {
     throw ApiError(message: 'Something went wrong');
   }
 }

 }

