
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/core/utils/cache_helper.dart';
import 'package:untitled3/features/auth/presentation/view/login_view.dart';

import 'package:untitled3/shared/custom_text/coustom_taxt.dart';

import 'app/root_app/root_app.dart';
import 'core/constants/app_color.dart';
import 'core/constants/cahce_key.dart';
import 'shared/navigetors/navigetor_to.dart';

class SplachApp extends StatefulWidget {
  const SplachApp({super.key});

  @override
  State<SplachApp> createState() => _SplachAppState();
}

class _SplachAppState extends State<SplachApp> {
  bool animate = false;
  bool isLoged =false;

  checklogin()async {
    Future.delayed(

      const Duration(seconds: 4),
          () {
        CacheKeys.token=CacheHelper.getData(key: 'userToken');
        isLoged = CacheKeys.token?.isNotEmpty??false;
        if( isLoged==true){
          navigatorto(context,  LoginView());
        }else{
          navigatorto(context,  LoginView());
        }

          }

    );
  }
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => animate = true);
    });
    checklogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Gap(220),
            AnimatedOpacity(
              duration:  Duration(milliseconds: 800),
              opacity: animate ? 1 : 0,
              child: CustomText(text: 'Clothes',
                color: Colors.white,
                font: FontWeight.w900,
                size: 80,),
            ),
             Spacer(),
            AnimatedSlide(
              duration: const Duration(milliseconds: 800),
              offset: animate ? Offset.zero : const Offset(0, .3),
              child: Image.asset('assets/images/splach-2.png',height: 400,width: 400,),
            ),
            Gap(3),
          ],
        ),
      ),
    );
  }
}
