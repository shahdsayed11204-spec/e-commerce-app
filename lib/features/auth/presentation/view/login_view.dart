import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/core/utils/cache_helper.dart';
import 'package:untitled3/features/auth/data/cubit/auth_cubit.dart';
import 'package:untitled3/features/auth/data/cubit/auth_states.dart';
import 'package:untitled3/features/auth/presentation/view/register_view.dart';
import 'package:untitled3/shared/custom_text/custom_snackbar.dart';
import 'package:untitled3/shared/navigetors/navigator_replace.dart';
import 'package:untitled3/shared/navigetors/navigetor_to.dart';
import '../../../../app/root_app/root_app.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/cahce_key.dart';
import '../../../../shared/custom_text/coustom_taxt.dart';
import '../../../../shared/custom_text/custom_textformfiled.dart';
import '../widget/custom_bottom.dart';

class LoginView extends StatelessWidget {
  final email = TextEditingController(text: 'ahd@gmail.com');
  final password = TextEditingController(text: '147258369');
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
              Gap(120),
              CustomText(
                text: 'Clothes',
                color: AppColors.primaryColor,
                font: FontWeight.w900,
                size: 80,
              ),
              Gap(10),
              CustomText(
                text: 'Welcome Back,Ready to refresh your wardrobe?',
                color: AppColors.primaryColor,
                font: FontWeight.w500,
                size: 13,
              ),
              Gap(50),
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
                          isPassword: context.watch<AuthCubit>().isPassword,
                          hint: 'Email Address',
                          controller: email,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please fill email';
                            }
                            return null;
                          },
                          prefix: Icons.email_outlined,
                        ),
                        Gap(15),
                        CustomTextformfiled(
                          hint: 'Password',
                          controller: password,
                          type: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please fill password';
                            } else if (value.length < 8) {
                              return 'password must be least 8 character';
                            }
                            return null;
                          },
                          isPassword: true,
                          prefix: Icons.lock_outline_rounded,
                          sufix: context.watch<AuthCubit>().sufix,
                          suffixprex: context
                              .watch<AuthCubit>()
                              .ChagnePassword,
                        ),
                        Gap(30),
                        BlocConsumer<AuthCubit, AuthStates>(
                          listener: (context, state) {
                            if (state is LoginSuccessStates) {
                              CacheKeys.token =
                                  state.userResponseModel.token ?? '';
                              CacheHelper.saveData(
                                key: 'userToken',
                                value: CacheKeys.token,
                              );
                              password.clear();
                              email.clear();
                              navigatorReplace(context, Root());
                            }
                            if (state is LoginErrorStates) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(customSnack(msg: state.message));
                            }
                          },

                          builder: (context, state) {
                            return ConditionalBuilder(
                              condition: state is! LoginLoadingStates,

                              builder: (context) => CustomBottom(
                                text: 'Login',
                                onTap: () {
                                  if (formkey.currentState!.validate()) {
                                    context.read<AuthCubit>().login(
                                      email: email.text,
                                      password: password.text,
                                    );
                                  }
                                },
                              ),

                              fallback: (context) => const Center(
                                child: CupertinoActivityIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                        Gap(15),
                        CustomBottom(
                          color: Colors.transparent,
                          textcolor: Colors.white,
                          text: 'Create Account?',
                          onTap: () {
                            navigatorto(context, RegisterView());
                          },
                        ),
                        Gap(15),
                        GestureDetector(
                          onTap: () {
                            navigatorReplace(
                            context, Root()
                            );
                          },
                          child: CustomText(
                            text: 'Continue as a guest ?',
                            color: Colors.white,
                          ),
                        ),
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
