import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled3/core/network/api_error.dart';
import 'package:untitled3/core/services/auth_services.dart';
import 'package:untitled3/features/auth/data/cubit/auth_states.dart';
import 'package:untitled3/features/auth/data/model/login_model/login_uesr_respons.dart';
import 'package:untitled3/features/auth/data/model/register_model/register_uesr_respons.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit():super(AuthInitialStates());

 AuthServices authServices=AuthServices();

 bool isPassword=true;
 IconData sufix= CupertinoIcons.eye_slash;
 void ChagnePassword(){
   isPassword = !isPassword;
   sufix= isPassword? CupertinoIcons.eye_slash: CupertinoIcons.eye;
   emit(AuthChangeStates());
 }

  Future<void>login({
    required String email,
    required String password,
})async{
    emit(LoginLoadingStates());
    try{
      LoginUserResponseModel? loginUserResponseModel= await authServices.Login(email: email, password: password);
      emit(LoginSuccessStates(userResponseModel:loginUserResponseModel! ));
    }
    catch (e) {
      if (e is ApiError) {
        emit(LoginErrorStates(e.message));
      } else {
        emit(LoginErrorStates('Something went wrong'));
      }
    }
  }

  Future<void>register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String rePassword,
})async{
    emit(RegisterLoadingStates());
    try{
      RegisterUserResponseModel? registerUserResponseModel= await authServices.register( name: name,
        email: email,
        phone: phone,
        password: password,
        rePassword: rePassword,);
      emit(RegisterSuccessStates());
    }
    catch (e) {
      if (e is ApiError) {
        emit(LoginErrorStates(e.message));
      } else {
        emit(LoginErrorStates('Something went wrong'));
      }
    }
  }
}