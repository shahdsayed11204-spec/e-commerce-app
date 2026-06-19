import 'package:dio/dio.dart';
import 'package:untitled3/core/constants/end_point.dart';
import 'package:untitled3/core/network/api_exceptions.dart';
import 'package:untitled3/core/network/dio_helper.dart';
import 'package:untitled3/features/order/data/model/cartI_tems_model.dart';

class OrderServices {
  final DioClient dioClient =DioClient();

  Future<List<DataCartItem>> getOrder()async{
    try{
      final response= await dioClient.dio.get(ordersuser);
      final List data=response.data['data']??[];
      return data.map((e) => DataCartItem.fromJson(e)).toList();
    }on DioException catch(e){
     throw ApiExceptions.handleError(e);
    }
    catch(e){
      throw Exception(e.toString());
    }
  }
}