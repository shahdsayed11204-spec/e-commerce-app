import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/features/order/data/cubit/order_states.dart';
import '../data/cubit/order_cubit.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 10),
      body: BlocBuilder<OrderCubit, OrderStates>(
        builder: (context, state) {

          if (state is OrderLoadingStates) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (state is OrderErrorStates) {
            return Center(child: Text(state.error));
          }

          if (state is OrderSuccessStates) {
            final orders = state.cart;

            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: orders.length,
              itemBuilder: (context, index) {

                final order = orders[index];
                final firstItem = (order.cartItems != null && order.cartItems!.isNotEmpty)
                    ? order.cartItems!.first
                    : null;

                return Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            /// IMAGE
                            CachedNetworkImage(
                              imageUrl: (firstItem?.product?.imageCover != null &&
                                  firstItem!.product!.imageCover!.isNotEmpty)
                                  ? firstItem.product!.imageCover!
                                  : 'https://via.placeholder.com/150',

                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,

                              errorWidget: (_, __, ___) => const Icon(Icons.error),
                            ),

                            const Gap( 10),

                            /// INFO
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    firstItem?.product?.title ?? 'No title',
                                  ),

                                  const Gap( 5),

                                  Text(
                                    "Qty: ${firstItem?.count ?? 0}",
                                  ),

                                  Text(
                                    "Price: ${firstItem?.price ?? 0}",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const Gap( 15),

                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}