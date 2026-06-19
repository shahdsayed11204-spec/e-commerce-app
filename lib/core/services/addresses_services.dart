import 'package:dio/dio.dart';
import 'package:untitled3/core/network/api_error.dart';
import 'package:untitled3/core/network/dio_helper.dart';
import '../../features/addresses/data/model/addresse_model.dart';
import '../constants/end_point.dart';
import '../network/api_exceptions.dart';


class AddressesServices {
  DioClient dioClient = DioClient();

  /// Add Addresses
  Future<List<Data>> addAddresses({
    required String name,
    required String details,
    required String phone,
    required String city,
  }) async {
    try {
      final response = await dioClient.dio.post(
        Addresses,
        data: {
          'name': name,
          'details': details,
          'phone': phone,
          'city': city,
        },
      );
      print(response.data);

      final addresses = (response.data['data'] as List)
          .map((e) => Data.fromJson(e))
          .toList();
      return addresses;


    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Get Addresses
  Future<List<Data>> getAddresses() async {
    try {
      final response = await dioClient.dio.get(Addresses);

      return (response.data['data'] as List)
          .map((e) => Data.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
  ///Delete Addresses
  Future<void> deleteAddresses(String id) async {
    try {
      await dioClient.dio.delete("$Addresses/$id");
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
