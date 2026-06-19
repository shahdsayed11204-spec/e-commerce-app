import 'package:flutter/material.dart';
import 'package:untitled3/core/constants/app_color.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryColor,),
        title: Text(title),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: AppColors.primaryColor,
        ),
        onTap: onTap,
      ),
    );
  }
}