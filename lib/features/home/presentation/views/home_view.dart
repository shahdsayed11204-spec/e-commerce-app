import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/features/home/data/cubit/home_cubit.dart';
import 'package:untitled3/features/home/data/cubit/home_state.dart';
import 'package:untitled3/features/home/presentation/widgets/search_home.dart';
import 'package:untitled3/features/home/presentation/widgets/uesr_header.dart';
import 'package:untitled3/shared/custom_text/coustom_taxt.dart';
import '../../../../core/constants/app_color.dart';
import '../widgets/cart.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(30),
                UesrHeader(),
                Gap(20),
                SearchHome(),
                Gap(20),
                BlocBuilder<HomeCubit, HomeStates>(
                  builder: (context, state) {
                    var cubit = BlocProvider.of<HomeCubit>(context);
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                            cubit.categorisModel.length, (
                          index,
                        ) {
                          return GestureDetector(
                            onTap: () {
                              cubit.changeCategory(index);
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.only(right: 8),
                              padding: EdgeInsets.symmetric(
                                horizontal: 27,
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: cubit.selectedIndex == index
                                    ? AppColors.primaryColor
                                    : Colors.grey[200],
                              ),
                              child: CustomText(
                                text:
                                    cubit.categorisModel[index].name??'',
                                font: FontWeight.w600,
                                color: cubit.selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
                Gap(20),
                CartItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




