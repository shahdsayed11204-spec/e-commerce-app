import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/shared/custom_text/coustom_taxt.dart';

SnackBar customSnack({required String msg,final Color?color}) {
  return SnackBar(
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.only(
      bottom: 40,
      left: 20,
      right: 20,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 5,
    backgroundColor: color,
    content: Row(
      children: [
        const Icon(
          CupertinoIcons.info_circle,
          color: Colors.white,
          size: 18,
        ),
        const Gap(10),
        Expanded(
          child: CustomText(
            text: msg,
            size: 11,
            font: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}