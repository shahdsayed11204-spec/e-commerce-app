import 'package:flutter/material.dart';
import 'package:untitled3/shared/custom_text/coustom_taxt.dart';

import '../../core/constants/app_color.dart';



class CustomBottomCart extends StatelessWidget {
  const CustomBottomCart({super.key, required this.text, this.onTap, this.width, this.height});

  final String text;
  final Function()? onTap;
  final double ? width;
  final double ? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
          height: height,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 30.0,vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadiusGeometry.circular(15),

          ),
          child: Center(child: CustomText(text: text,size: 18,font: FontWeight.bold,color: Colors.white))
      ),
    );
  }
}
