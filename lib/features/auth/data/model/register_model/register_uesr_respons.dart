
import 'package:untitled3/features/auth/data/model/register_model/uesr.dart';

class RegisterUserResponseModel {
  final String? message;
  final UserModel? user;
  final String? token;

  const RegisterUserResponseModel({this.message, this.user, this.token});

  factory RegisterUserResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserResponseModel(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'user': user?.toJson(),
    'token': token,
  };

  @override
  List<Object?> get props => [message, user, token];
}