import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/features/products/view/products_details.dart';
import 'package:untitled3/shared/custom_text/coustom_taxt.dart';
import 'package:untitled3/shared/navigetors/navigetor_to.dart';
import '../../../../core/constants/app_color.dart';
import '../../../favorite/data/cubit/cubit_favoite.dart';
import '../../data/cubit/home_cubit.dart';
import '../../data/cubit/home_state.dart';

Widget CartItem() => BlocBuilder<HomeCubit, HomeStates>(
  builder: (context, state) {
    final cubit = context.watch<HomeCubit>();
    final favoriteCubit = context.watch<FavoritesCubit>();
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
        final isFavorite = favoriteCubit.isFavorite(product.id!);
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
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: product.imageCover ?? '',
                              fit: BoxFit.contain,
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                              const Center(
                                child: CupertinoActivityIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                              const Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),

                        if (hasDiscount)
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              child: const Text(
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
                      IconButton(

                        onPressed: () {
                          if (isFavorite) {
                            favoriteCubit.deleteFavorite(product.id!);
                          } else {
                            favoriteCubit.addFavorite(product.id!);
                          }
                        },
                        icon: Icon(
                          isFavorite
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart,
                          color: isFavorite ? AppColors.primaryColor: Colors.grey,
                        ),
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