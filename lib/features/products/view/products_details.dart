import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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

class ProductDetailsView extends StatefulWidget {
  final ProductData product;

  const ProductDetailsView({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  static const _primary = Color(0xFF7FA191);
  static const _dark = Color(0xFF2C3E35);

  int _selectedImageIndex = -1;

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images ?? [];

    final String mainImageUrl = _selectedImageIndex == -1
        ? (widget.product.imageCover ?? '')
        : images[_selectedImageIndex];

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

              Container(
                height: 320,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F2F1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: CachedNetworkImage(
                    imageUrl: mainImageUrl,
                    width: 125,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, progress) =>
                        CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
              ),

              const Gap(16),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(images.length, (index) {
                    final isSelected = _selectedImageIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImageIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 12),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppColors.primaryColor : Colors.transparent,
                            width: 2.5,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const Gap(24),

              Text(
                widget.product.title ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _dark,
                ),
              ),

              const Gap(4),

              Text(
                widget.product.brand?.name ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const Gap(12),

              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFE6A83C), size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.product.ratingsAverage ?? 0}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${widget.product.ratingsQuantity ?? 0} Reviews)',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              const Gap(20),

              Row(
                children: [
                  Text(
                    'USD ${widget.product.price ?? 0}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _dark,
                    ),
                  ),
                  const Gap(16),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF2EE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Free Shipping',
                      style: TextStyle(
                        color: Color(0xFF6B8E7D),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const Gap(8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF2EE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
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
              const Gap(30),
              // BUTTONS
              Row(
                children: [
                  Expanded(
                    flex: 11,
                    child: BlocListener<CartCubit, CartStates>(
                      listener: (BuildContext context, CartStates state) {
                        if (state is AddToCartSuccessStates) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnack(msg: 'Added to Cart', color: Colors.green,icon: Icons.check_circle),
                          );
                        } else if (state is AddToCartErrorStates) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnack(msg: 'Error', color: Colors.red),
                          );
                        }
                      },
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final cubit = context.read<CartCubit>();
                          if (widget.product.id == null) return;
                          cubit.addToCart(widget.product.id!);
                        },
                        icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                        label: CustomText(text: 'ADD TO CART', color: Colors.white),
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
                  const Gap(12),
                  Expanded(
                    flex: 9,
                    child: ElevatedButton(
                      onPressed: () {
                        final cartCubit= context.read<CartCubit>();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: cartCubit,
                              child:  CartView(),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: CustomText(text: 'Show Order you', color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}