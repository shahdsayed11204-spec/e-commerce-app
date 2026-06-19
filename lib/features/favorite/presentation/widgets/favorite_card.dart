import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/favorite/data/cubit/cubit_favoite.dart';

import '../../../../shared/custom_text/custom_snackbar.dart';
import '../../../cart/data/cubit/cart_cubit.dart';
import '../../../cart/data/cubit/cart_states.dart';
import '../../../home/data/models/products/product_model.dart';
import '../../data/cubit/state_favoite.dart';
import '../../data/model/favorite_model.dart';

class FavoriteCard extends StatelessWidget {


  final Product product;
   final ProductData  productData;

  const FavoriteCard( {super.key, required this.product, required this.productData});



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl:product.imageCover ?? '',
                    width: 125,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, progress) =>
                    const CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                       product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.orange, size: 18),
                          const SizedBox(width: 4),
                          Text(productData.ratingsAverage.toString()),
                          const SizedBox(width: 6),
                          Text(
                            productData.ratingsQuantity.toString(),
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "${product.price ?? 0} EGP",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          "In Stock",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [


                Expanded(
                  child: BlocListener<CartCubit, CartStates>(
                    listener: (context, state) {
                      if (state is AddToCartSuccessStates) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          customSnack(
                            msg: 'Added to Cart',
                            color: Colors.green,
                            icon: Icons.check_circle,
                          ),
                        );
                      } else if (state is AddToCartErrorStates) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          customSnack(
                            msg: 'Error',
                            color: Colors.red,
                          ),
                        );
                      }
                    },
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<CartCubit>().addToCart(product.id);
                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                      label: const Text("Add to Cart"),
                    ),
                  ),
                ),


                const SizedBox(width: 10),

                BlocListener<FavoritesCubit, FavoritesStates>(
                  listener: (context, state) {
                    if (state is FavoritesDeleteSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        customSnack(
                          msg: 'Removed from Favorites',
                          color: Colors.red,
                          icon: Icons.delete,
                        ),
                      );
                    } else if (state is FavoritesDeleteErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        customSnack(
                          msg: 'Error while removing',
                          color: Colors.red,
                        ),
                      );
                    }
                  },
                  child: IconButton(
                    onPressed: () {
                      final cubit = context.read<FavoritesCubit>();
                      cubit.deleteFavorite(product.id!);
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}