import 'package:untitled3/features/auth/data/model/login_model/login_uesr_respons.dart';

abstract class AuthStates {}

class AuthInitialStates extends AuthStates {}

class AuthChangeStates extends AuthStates {}

class LoginLoadingStates extends AuthStates {}

class LoginSuccessStates extends AuthStates {
  final LoginUserResponseModel userResponseModel;

  LoginSuccessStates({required this.userResponseModel});
}

class LoginErrorStates extends AuthStates {
  final String message;

  LoginErrorStates(this.message);
}

class RegisterLoadingStates extends AuthStates {}

class RegisterSuccessStates extends AuthStates {

}

class RegisterErrorStates extends AuthStates {
  final String message;

  RegisterErrorStates(this.message);
}


class ProfileLoadingStates extends AuthStates {}

class ProfileSuccessStates extends AuthStates {

}

class ProfileErrorStates extends AuthStates {
  final String message;

  ProfileErrorStates(this.message);
}

class ProfileImagePickedState extends AuthStates {}

class AuthGuestState extends AuthStates {}
class AuthSuccessState extends AuthStates {

}

