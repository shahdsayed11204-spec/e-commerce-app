import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled3/core/network/api_error.dart';
import 'package:untitled3/core/services/auth_services.dart';
import 'package:untitled3/features/auth/data/cubit/auth_states.dart';
import 'package:untitled3/features/auth/data/model/login_model/login_uesr_respons.dart';
import 'package:untitled3/features/auth/data/model/register_model/register_uesr_respons.dart';

import '../../../../core/constants/cahce_key.dart' show CacheKeys;
import '../../../../core/utils/cache_helper.dart';
import '../model/profile_model/profile_model.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit():super(AuthInitialStates());

  AuthServices authServices=AuthServices();

  LoginUserResponseModel?loginUserResponseModel;
  RegisterUserResponseModel? registerUserResponseModel;
  ProfileModel? profileModel;
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
      loginUserResponseModel= await authServices.Login(email: email, password: password);
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
      registerUserResponseModel= await authServices.register( name: name,
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

  Future<void>getProfile()async {
    emit(ProfileLoadingStates());
    try {
      profileModel = await authServices.getProfile();
      emit(ProfileSuccessStates());
    }
    catch (e) {
      print('PROFILE ERROR => $e');
      if (e is ApiError) {
        emit(ProfileErrorStates(e.message));
      } else {
        emit(ProfileErrorStates('Something went wrong'));
      }
    }
  }


  String ?selectedImage;
  Future<void>pickImage()async{
    final pickImage= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickImage !=null){
      selectedImage=pickImage.path;
      emit(ProfileImagePickedState());
    }
  }


  Future<void> autoLogin() async {
    final token = await CacheHelper.getData(key: CacheKeys.token??"");

    if (token == null || token == 'guest') {
      emit(AuthGuestState());
      return;
    }

    try {
      await getProfile();
      emit(AuthSuccessState());
    } catch (e) {
      await CacheHelper.removeData(key: CacheKeys.token??'');
      emit(AuthGuestState());
    }
  }
}