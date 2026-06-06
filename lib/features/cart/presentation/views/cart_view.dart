import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/features/cart/data/cubit/cart_states.dart';
import '../../../../shared/custom_text/coustom_taxt.dart';
import '../../../../shared/custom_text/custom_bottom_cart.dart';
import '../../data/cubit/cart_cubit.dart';
import '../widgets/cart_item_card.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartStates>(
      builder: (context, state) {
        final cubit = context.read<CartCubit>();

        if (state is GetCartLoadingStates) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetCartErrorStates) {
          return Center(child: Text(state.message));
        }
        final cart = cubit.cartModel;
        if (cart == null || cart.data == null || cart.data!.products!.isEmpty) {
          return const Center(child: Text('No Products Yet !!'));
        }

        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const Gap(20),
                      Column(
                        children: List.generate(cart.data!.products!.length, (
                          index,
                        ) {
                          final item = cart.data!.products![index];
                          return CartItemCard(
                            image: item.product?.imageCover ?? '',
                            text: item.product?.title ?? '',
                            number: item.count ?? 1,
                            onPlus: () {
                              cubit.updateItem(item.id!, item.count! + 1);
                            },
                            onMins: () {
                              if (item.count! > 1) {
                                cubit.updateItem(
                                  item.id!,
                                  item.count! - 1,
                                  // cubit.addToCart(item.id!);
                                );
                              }
                            },
                            onRemove: () {
                              cubit.removeItem(item.id!);
                            },
                          );
                        }),
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: 'Total', size: 16),
                        CustomText(
                          text: '\$${cart.data?.totalCartPrice ?? 0}',
                          size: 25,
                          font: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    flex: 12,
                    child: CustomBottomCart(text: 'Check out', onTap: () {}),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
