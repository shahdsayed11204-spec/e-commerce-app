import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/features/auth/data/cubit/auth_cubit.dart';
import 'package:untitled3/features/auth/data/cubit/auth_states.dart';
import 'package:untitled3/shared/custom_text/custom_snackbar.dart';
import 'package:untitled3/shared/navigetors/navigetor_to.dart';
import '../../../../app/root_app/root_app.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/custom_text/coustom_taxt.dart';
import '../../../../shared/custom_text/custom_textformfiled.dart';
import '../../../../shared/navigetors/navigator_replace.dart';
import '../widget/custom_bottom.dart';

class RegisterView extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final repassword = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formkey,
          child: Column(
            children: [
              Gap(80),
              CustomText(
                text: 'Clothes',
                color: AppColors.primaryColor,
                font: FontWeight.w900,
                size: 70,
              ),
              CustomText(
                text: 'Register Now , Create Account......?',
                color: AppColors.primaryColor,
                font: FontWeight.w500,
                size: 13,
              ),
              Gap(15),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        CustomTextformfiled(
                          hint: 'Name',
                          controller: name,
                          type: TextInputType.text,
                          isPassword: false,
                        ),
                        Gap(10),
                        CustomTextformfiled(
                          isPassword: false,
                          hint: 'Email Address',
                          controller: email,
                          type: TextInputType.emailAddress,
                        ),
                        Gap(10),
                        CustomTextformfiled(
                          hint: 'Password',
                          controller: password,
                          type: TextInputType.visiblePassword,
                          isPassword: true,
                          validator: (value) {
                            if(value==null||value.isEmpty){
                              return 'please fill password';
                            }else if(value.length< 8){
                              return 'password must be least 8 character';
                            }
                            return null;
                          },
                        ),
                        Gap(10),
                        CustomTextformfiled(
                          hint: 'Re-Password',
                          controller: repassword,
                          type: TextInputType.visiblePassword,
                          isPassword: true,
                          validator: (value) {
                            if(value==null||value.isEmpty){
                              return 'please fill Re-password';
                            }else if(value.length< 8){
                              return 'password must be least 8 character';
                            }else if(value!=password.text){
                              return 'Re-password not match';
                            }
                            return null;
                          },
                        ),
                        Gap(10),        CustomTextformfiled(
                          hint: 'Phone',
                          controller: phone,
                          type: TextInputType.phone,
                          isPassword: false,
                        ),
                        Gap(25),
                        BlocListener<AuthCubit, AuthStates>(
                          listener: (context, state) {
                            if (state is RegisterSuccessStates) {
                              navigatorReplace(
                                context,
                                Root(),
                              );
                            }
                            if (state is RegisterErrorStates) {
                             customSnack(msg: 'Error .. Please try again');
                            }
                          },
                          child: CustomBottom(
                            text: 'Register',
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                context.read<AuthCubit>().register(
                                  email: email.text,
                                  password: password.text,
                                  name: name.text,
                                  rePassword: repassword.text,
                                  phone: phone.text,
                                );
                              }
                            },
                          ),
                        ),
                        Gap(15),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
