
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/custom_text/coustom_taxt.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.image,
    required this.text,
     this.desc,
    this.onMins,
    this.onPlus,
    this.onRemove,
    required this.number
  });

  final String image,text;
  final String?desc;
  final Function()? onMins;
  final Function()? onPlus;
  final Function()? onRemove;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20)
      ),
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(image,width:100,fit: BoxFit.cover,height: 150,),
                  Gap(5),
                  CustomText(text: text,font: FontWeight.bold,size: 13),
                ],
              ),
            ),
            Gap(10),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 38,
                      height: 38,
                      child: FloatingActionButton(
                        heroTag: null,
                        mini: true,
                        onPressed: onMins,
                        child: Icon(CupertinoIcons.minus ,
                          color: Colors.white,
                        ),
                        backgroundColor: AppColors.primaryColor,
                        elevation: 5,
                      ),
                    ),
                    Gap(15),
                    CustomText(text: number.toString(),font: FontWeight.bold,size: 23),
                    Gap(15),
                    SizedBox(
                      width: 38,
                      height: 38,
                      child: FloatingActionButton(
                        heroTag: null,
                        mini: true,
                        onPressed: onPlus,
                        child: Icon(CupertinoIcons.plus,
                          color: Colors.white,
                        ),
                        elevation: 5,
                        backgroundColor: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                Gap(20),
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 35.0,vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadiusGeometry.circular(30),
                      ),
                      child: CustomText(text: 'Remove',size: 18,font: FontWeight.bold,color: Colors.white)
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}


