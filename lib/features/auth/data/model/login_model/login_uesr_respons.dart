import 'package:untitled3/features/auth/data/model/login_model/uesr.dart';

class LoginUserResponseModel {
  String? message;
  User? user;
  String? token;

  LoginUserResponseModel({this.message, this.user, this.token});

  factory LoginUserResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginUserResponseModel(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'user': user?.toJson(),
    'token': token,
  };
}