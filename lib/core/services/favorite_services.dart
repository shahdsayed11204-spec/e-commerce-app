import 'package:dio/dio.dart';
import 'package:untitled3/core/network/api_exceptions.dart';
import 'package:untitled3/core/network/dio_helper.dart';

import '../../features/favorite/data/model/favorite_model.dart';
import '../constants/end_point.dart';
import '../network/api_error.dart';

class FavoriteServices {
  
  final DioClient dioClient=DioClient();
  /// Get Fav
  Future<FavoriteModel>getFavorite()async{
    try{
      final response= await dioClient.dio.get(fav);
      return FavoriteModel.fromJson(response.data);
    }on DioException catch(error){
     throw ApiExceptions.handleError(error);
    }
    catch(e){
      throw ApiError(message: 'Something went wrong');
    }
  }

  /// Add Fav
  Future<void>addFavorite(String productId)async{
    try{
      final response= await dioClient.dio.post(fav,data: {
        'productId':productId,
      });
    }on DioException catch(error){
      throw ApiExceptions.handleError(error);
    }
    catch(e){
      throw ApiError(message: 'Something went wrong');
    }
  }
  /// Delete Fav
  Future<void>deleteFavorite(String productId)async{
    try{
      final response= await dioClient.dio.delete('$fav/$productId');
    }on DioException catch(error){
      throw ApiExceptions.handleError(error);
    }
    catch(e){
      throw ApiError(message: 'Something went wrong');
    }
  }
}