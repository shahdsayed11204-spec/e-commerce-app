
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/constants/app_color.dart';
import 'coustom_taxt.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.color,
    this.height,
    this.radius,
    this.textColor,
    this.widget,
    this.gap, this.icon,
  });

  final String text;
  final Function()? onTap;
  final double? width;
  final double? height;
  final Color? color;
  final double? radius;
  final Color? textColor;
  final Widget? widget;
  final double? gap;
  final IconData?icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 50,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(radius ?? 10),
            border: Border.all(
        color: Colors.white60.withOpacity(0.5),
      ),
        ),
        child: Row(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            CustomText(text: text, color: textColor ?? Colors.white, size: 15, font: FontWeight.w500),
            Icon(icon,color: Colors.white,size: 18,),
            Gap(gap ?? 0.0),
            widget ?? SizedBox.shrink(),

          ],
        ),
      ),
    );
  }
}