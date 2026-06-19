import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/core/constants/end_point.dart';
import 'package:untitled3/features/cart/data/cubit/cart_states.dart';
import 'package:untitled3/features/check_out/presentation/views/check_out_view.dart';
import 'package:untitled3/shared/navigetors/navigetor_to.dart';

import '../../../../shared/custom_text/custom_bottom_cart.dart';
import '../../data/cubit/cart_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Cart",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {
          if (state is RemoveCartSuccessStates) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item removed successfully'),
                backgroundColor: Color(0xFF2C3E35),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(15),
              ),
            );
            context.read<CartCubit>().getCart();
          }
        },
        builder: (context, state) {
          final cubit = context.read<CartCubit>();
          final cart = cubit.cartModel;

          if (state is GetCartLoadingStates && cart == null) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2196F3)),
            );
          }

          if (state is GetCartErrorStates && cart == null) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }

          if (cart == null ||
              cart.data == null ||
              cart.data!.products!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 70,
                    color: Colors.grey.shade400,
                  ),
                  const Gap(16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async => await cubit.getCart(),
                      color: const Color(0xFF7FA191),
                      backgroundColor: Colors.white,
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 10,
                          bottom: 100,
                        ),
                        itemCount: cart.data!.products!.length,
                        separatorBuilder: (context, index) => const Gap(12),
                        itemBuilder: (context, index) {
                          final item = cart.data!.products![index];
                          final productId = item.product?.id ?? '';

                          final bool isLoading = state is RemoveCartItemLoadingState && state.productId == productId;

                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.white,
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [

                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(14),
                                          child: Image.network(
                                            item.product?.imageCover ?? '',
                                            width: 85,
                                            height: 95,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const Gap(12),
                                        Expanded(
                                          child: Text(
                                            item.product?.title ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF2C3E35),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Gap(8),

                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 36,
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF3F5F4),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                visualDensity: VisualDensity.compact,
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                                icon: const Icon(CupertinoIcons.minus, size: 13, color: Colors.black87),
                                                onPressed: () {
                                                  if (item.count! > 1) {
                                                    cubit.updateItem(productId, item.count! - 1);
                                                  }
                                                },
                                              ),
                                              const Gap(8),
                                              Text(
                                                item.count.toString(),
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF2C3E35),
                                                ),
                                              ),
                                              const Gap(8),
                                              IconButton(
                                                visualDensity: VisualDensity.compact,
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                                icon: const Icon(CupertinoIcons.plus, size: 13, color: Colors.black87),
                                                onPressed: () => cubit.updateItem(productId, item.count! + 1),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const Gap(14),

                                        GestureDetector(
                                          onTap: isLoading ? null : () => cubit.removeItem(productId),
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 200),
                                            height: 34,
                                            width: 95,
                                            decoration: BoxDecoration(
                                              color: isLoading ? const Color(0xFFEAEAEA) : const Color(0xFFFCECEF),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: isLoading
                                                  ? const CupertinoActivityIndicator(radius: 7, color: Colors.redAccent)
                                                  : const Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(CupertinoIcons.trash, size: 13, color: Colors.redAccent),
                                                  Gap(4),
                                                  Text(
                                                    'Remove',
                                                    style: TextStyle(
                                                      color: Color(0xFFD32F2F),
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 20,
                        offset: const Offset(0, -6),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total price',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                '\$${cart.data?.totalCartPrice ?? 0}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C3E35),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 54,
                            child: CustomBottomCart(
                              text: 'Check out',
                              onTap: () {
                            navigatorto(context, CheckoutView(
                              cartId: cart.data!.cartId.toString(),
                              totalCartPrice: cart.data?.totalCartPrice ?? 0,));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}