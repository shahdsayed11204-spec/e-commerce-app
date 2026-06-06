import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/app/root_app/root_cubit/root_cubit.dart';
import 'package:untitled3/app/root_app/root_cubit/root_states.dart';

import '../../core/constants/app_color.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit(),
      child: BlocBuilder<RootCubit,RootStates>(
        builder: ( context,  state) {
         var cubit=context.read<RootCubit>();
          return  Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: Scaffold(
              body: cubit.screen[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(

                selectedItemColor: AppColors.primaryColor,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.ChangeBottomNav(index);
                },
                items: cubit.BottomNav,
                type: BottomNavigationBarType.fixed,
              ),
            ),
          );
        },

      ),
    );
  }
}
