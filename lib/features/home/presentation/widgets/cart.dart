import 'package:cached_network_image/cached_network_image.dart';
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

Widget CartItem() => BlocBuilder<HomeCubit, HomeStates>(
  builder: (context, state) {
    final cubit = context.watch<HomeCubit>();

    if (state is HomeProductsLoadingStates) {
      return const Center(child: CircularProgressIndicator());
    }

    if (cubit.filteredProducts.isEmpty) {
      return  Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        CustomText(text: 'No Products',font: FontWeight.w100,size: 20),
          const Icon(Icons.shopping_cart_outlined,color: Colors.grey,),
      ],));
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: cubit.filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

        return GestureDetector(
          onTap: () {
            navigatorto(
              context,
              ProductDetailsView(product: product),
            );
          },
          child: Card(
            elevation: 5,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Center(
                          child: CachedNetworkImage(
                            imageUrl: product.imageCover ?? '',
                            width: 125,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                        if (hasDiscount)
                          Container(
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 2,
                              ),
                              child: Text(
                                "SALE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: product.title ?? '',
                        font: FontWeight.bold,
                      ),
                      CustomText(text: product.description ?? ''),
                    ],
                  ),
                  Row(
                    children: [
                      if (hasDiscount)
                        CustomText(
                          text: product.priceAfterDiscount.toString(),
                        ),
                      if (hasDiscount) const Gap(20),
                      if (hasDiscount)
                        CustomText(
                          text: product.price.toString(),
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        )
                      else
                        CustomText(text: product.price.toString()),
                      const Spacer(),
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
      },
    );
  },
);