import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/shared/custom_text/coustom_taxt.dart';

import '../../../../core/constants/app_color.dart';

class UesrHeader extends StatelessWidget {
  const UesrHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              text: 'Clothes App',
              color: AppColors.primaryColor,
              font: FontWeight.w900,
              size: 40,
            ),
            CustomText(
              text: 'Hello, Shahd Sayed',
              color: Colors.grey.shade500,
              font: FontWeight.w700,
              size: 15,
            ),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade200,
          child: Icon(
            CupertinoIcons.person,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
