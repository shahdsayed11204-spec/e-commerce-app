import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/core/constants/app_color.dart';
import 'package:untitled3/features/cart/data/cubit/cart_cubit.dart';
import 'package:untitled3/features/cart/data/cubit/cart_states.dart';
import 'package:untitled3/features/cart/presentation/views/cart_view.dart';
import 'package:untitled3/features/home/data/models/products/product_model.dart';
import 'package:untitled3/shared/custom_text/coustom_taxt.dart';
import 'package:untitled3/shared/custom_text/custom_snackbar.dart';
import 'package:untitled3/shared/navigetors/navigator_replace.dart';
import 'package:untitled3/shared/navigetors/navigetor_to.dart';

class ProductDetailsView extends StatelessWidget {
  static const _primary = Color(0xFF7FA191);
  static const _dark = Color(0xFF2C3E35);

  final ProductData product;

  const ProductDetailsView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final images = product.images ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.favorite_border, color: Colors.black87),
          Gap(16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),

              // MAIN IMAGE
              Container(
                height: 320,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F2F1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    product.imageCover ?? '',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),

               Gap(16),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(images.length, (index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                ),
              ),

               Gap(24),

              Text(
                product.title ?? '',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _dark,
                ),
              ),

              Gap( 4),

              Text(
                product.brand?.name ?? '',
                style:  TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

               Gap(12),

              Row(
                children: [
                   Icon(Icons.star,
                      color: Color(0xFFE6A83C), size: 18),
                   SizedBox(width: 4),
                  Text(
                    '${product.ratingsAverage ?? 0}',
                    style:  TextStyle(fontWeight: FontWeight.bold),
                  ),
                   SizedBox(width: 4),
                  Text(
                    '(${product.ratingsQuantity ?? 0} Reviews)',
                    style:  TextStyle(color: Colors.grey),
                  ),
                ],
              ),

               Gap(20),

              Row(
                children: [
                  Text(
                    'USD ${product.price ?? 0}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _dark,
                    ),
                  ),
                  Gap( 16),

                  Container(
                    padding:  EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF2EE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:  Text(
                      'Free Shipping',
                      style: TextStyle(
                        color: Color(0xFF6B8E7D),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Gap( 8),

                  Container(
                    padding:  EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color:  Color(0xFFEAF2EE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:  Text(
                      'In Stock',
                      style: TextStyle(
                        color: Color(0xFF6B8E7D),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

               Gap(30),

              // BUTTONS
              Row(
                children: [
                  Expanded(
                    flex: 11,
                    child: BlocListener<CartCubit,CartStates>(
                      listener: (BuildContext context, CartStates state) {
                        if(state is AddToCartSuccessStates){
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnack(msg: 'Added to Cart',color: Colors.green),
                          );
                        }else if(state is AddToCartErrorStates){
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnack(msg: 'Error',color: Colors.red),
                          );
                        }
                      },
                      child: ElevatedButton.icon(
                        onPressed: () {
                            final cubit = context.read<CartCubit>();

                            if (product.id == null) return;

                            cubit.addToCart(product.id!);

                        },
                        icon: const Icon(Icons.shopping_bag_outlined,
                            color: Colors.white),
                        label: CustomText(text: 'ADD TO CART',color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap( 12),
                  Expanded(
                    flex: 9,
                    child: ElevatedButton(
                      onPressed: () {
                        navigatorReplace(context, CartView());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding:  EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),

                      ),
                      child: CustomText(text: 'Show Order you',color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),

               Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}