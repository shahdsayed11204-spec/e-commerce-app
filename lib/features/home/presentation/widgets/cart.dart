import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/features/products/view/products_details.dart';
import 'package:untitled3/shared/custom_text/coustom_taxt.dart';
import 'package:untitled3/shared/navigetors/navigetor_to.dart';
import '../../../../core/constants/app_color.dart';
import '../../data/cubit/home_cubit.dart';
import '../../data/cubit/home_state.dart';

Widget CartItem()=> BlocBuilder<HomeCubit, HomeStates>(
  builder: ( context,  state) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return  ConditionalBuilder(
      condition: state is! HomeProductsLoadingStates,
      builder: (context)=>GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: cubit.filteredProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.60,
            mainAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            final product = cubit.filteredProducts[index];
            final hasDiscount =
                product.priceAfterDiscount != null &&
                    product.priceAfterDiscount != 0 &&
                    product.priceAfterDiscount! < product.price!;
            return  GestureDetector(
              onTap: (){navigatorto(context, ProductDetailsView(product: product));},
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Stack(
                        children: [
                          Center(child: Image.network(product.imageCover??'',width: 125,fit: BoxFit.cover)),
                          if(hasDiscount)
                            Container(
                              color: Colors.red,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 7.0,vertical: 2),
                                  child: CustomText(text: 'SALE',color: Colors.white,size: 10,font: FontWeight.bold)
                              ),
                            ),
                        ],
                      )
                      ),
                      Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text:product.title??'',font: FontWeight.bold),
                          CustomText(text: product.description??''),
                        ],
                      ),
                      Row(
                        children: [
                          if (hasDiscount)
                            CustomText(
                              text: product.priceAfterDiscount.toString(),
                            ),
                          if (hasDiscount) Gap(20),
                          if (hasDiscount)
                            CustomText(
                              text: product.price.toString(),
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            )
                          else
                            CustomText(
                              text: product.price.toString(),
                            ),
                          Spacer(),
                          Icon(
                            CupertinoIcons.suit_heart,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ),
            );
          }
      ),
      fallback: (context)=>Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  },

);
