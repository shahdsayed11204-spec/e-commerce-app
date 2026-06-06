import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/app/root_app/root_cubit/root_states.dart';
import 'package:untitled3/features/auth/presentation/view/profile_view.dart';
import 'package:untitled3/features/home/presentation/views/home_view.dart';
import 'package:untitled3/features/order/views/order_view.dart';

import '../../../features/cart/presentation/views/cart_view.dart';

class RootCubit extends Cubit<RootStates> {
  RootCubit() : super(RootInitialStates());

  int currentIndex = 0;

  List<BottomNavigationBarItem> BottomNav = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.reorder_rounded),
      label: 'Order',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline_rounded),
      label: 'Profile',
    ),
  ];

  List<Widget> screen = [HomeView(), CartView(), OrderView(),ProfileView()];

  void ChangeBottomNav(int index) {
    currentIndex = index;
    emit(RootBottomNavSheetStates());
  }
}

