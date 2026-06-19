import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/custom_text/coustom_taxt.dart' show CustomText;
import '../../data/cubit/auth_cubit.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.name, required this.role});

  final String name;
  final String role;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 8
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Colors.black),
                  color: Colors.grey.shade300,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: AppColors.primaryColor,
                        ),
                        color: Colors.grey.shade100,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: context.watch<AuthCubit>(). selectedImage != null
                          ? Image.file(
                        File(context.read<AuthCubit>().selectedImage!),
                        fit: BoxFit.cover,
                      ) : Icon(Icons.person_outline_rounded),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 3,
                right: 5,
                child:  CircleAvatar(
                child: IconButton(onPressed: (){
                  context.read<AuthCubit>().pickImage();
                }, icon:Center(child: Icon( Icons.camera_alt_outlined,color: Colors.grey.shade600,))),
              ),),

            ],
          ),

          const Gap( 12),
        CustomText(
          text: name,
          color: Colors.black,
          size: 22,
          font: FontWeight.bold,
        ),
          const Gap( 4),
          CustomText(
            text: role,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
