import 'package:dio/dio.dart';
import 'package:untitled3/core/constants/cahce_key.dart';
import 'package:untitled3/core/network/api_error.dart';
import 'package:untitled3/core/network/dio_helper.dart';
import 'package:untitled3/features/auth/data/model/login_model/login_uesr_respons.dart';
import 'package:untitled3/features/auth/data/model/profile_model/profile_model.dart';
import 'package:untitled3/features/auth/data/model/register_model/register_uesr_respons.dart';

import '../constants/end_point.dart';
import '../network/api_exceptions.dart';
import '../utils/cache_helper.dart';

class AuthServices {
  DioClient dioClient = DioClient();
  bool isGuest = false;

  /// login
  Future<LoginUserResponseModel?> Login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioClient.dio.post(
        loginin,
        data: {'email': email, 'password': password},
      );
      Map<String, dynamic> jsondata = response.data;
      LoginUserResponseModel loginUserResponseModel =
      LoginUserResponseModel.fromJson(jsondata);
      return loginUserResponseModel;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: 'Something went wrong');
    }
  }

  /// register
  Future<RegisterUserResponseModel?> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String rePassword,
  }) async {
    try {
      final response = await dioClient.dio.post(
        registerup,
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
          "rePassword": rePassword,
        },
      );
      Map<String, dynamic> jsonData = response.data;
      RegisterUserResponseModel registerUserResponseModel =
      RegisterUserResponseModel.fromJson(jsonData);
      return registerUserResponseModel;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      print(e);
    }
  }

  ///Profile
  Future<ProfileModel> getProfile() async {
    try {
      final response = await dioClient.dio.get(profile);
      Map<String, dynamic> jsonData = response.data;
      print(jsonData);
      return ProfileModel.fromJson(
          jsonData
      );
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }


}