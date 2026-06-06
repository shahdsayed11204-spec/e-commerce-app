import 'package:flutter/material.dart';
import 'package:untitled3/features/auth/presentation/view/login_view.dart';

  void Navigatendfinish( context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic>route)=>false,
  );
