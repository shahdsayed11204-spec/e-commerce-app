import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/features/auth/data/cubit/auth_cubit.dart';
import 'package:untitled3/features/auth/presentation/view/login_view.dart';
import 'package:untitled3/features/favorite/presentation/view/favorite_view.dart';
import 'package:untitled3/features/order/data/cubit/order_cubit.dart';
import 'package:untitled3/features/order/views/order_view.dart';
import 'package:untitled3/shared/navigetors/navigator_replace.dart';
import 'package:untitled3/shared/navigetors/navigetor_to.dart';
import '../../../addresses/data/cubit/addresse_cubit.dart';
import '../../../addresses/presentation/view/addresses_view.dart';
import '../../../order/data/cubit/order_states.dart';
import '../../data/cubit/auth_states.dart';
import '../widget/profile_header.dart';
import '../widget/profile_statcard.dart';
import '../widget/profile_tile.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (BuildContext context, state) {
        final orderCubit = context.watch<OrderCubit>();
        final count = (orderCubit.state is OrderSuccessStates)
            ? (orderCubit.state as OrderSuccessStates).cart.length
            : 0;
        final addressesCubit = context.read<AddressesCubit>();
        final cubit = BlocProvider.of<AuthCubit>(context);
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: RefreshIndicator(
            onRefresh: ()async {
              await  context.read<OrderCubit>().getOrder();
              await  context.read<AddressesCubit>().GetAddresses();
              await  context.read<AuthCubit>().getProfile();
            },
            color: const Color(0xFF5F8CAE),
            backgroundColor: Colors.white,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Gap(20),
                  ProfileHeader(
                    name: cubit.profileModel?.name ?? '',
                    role: cubit.profileModel?.role ?? '',
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      ProfileStatCard(title: "Orders", count: count.toString()),
                      const SizedBox(width: 12),
                      ProfileStatCard(
                        title: "Addresses",
                        count: addressesCubit.addresseModel.length.toString(),
                      ),
                    ],
                  ),

                  const Gap(20),

                  ProfileTile(
                    icon: Icons.location_on_outlined,
                    title: "My Addresses",
                    onTap: () {
                      navigatorto(context, AddressesView());
                    },
                  ),

                  ProfileTile(
                    icon: Icons.shopping_bag_outlined,
                    title: "My Orders",
                    onTap: () {
                      navigatorto(context, HistoryView());
                    },
                  ),

                  ProfileTile(
                    icon: Icons.favorite_outline,
                    title: "Favorite",
                    onTap: () {
                      navigatorto(context, FavoritesView());
                    },
                  ),

                  ProfileTile(
                    icon: Icons.logout,
                    title: "Logout",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: const Text("Confirm Logout"),
                            content: const Text("Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext);

                                  navigatorReplace(context, LoginView());
                                },
                                child: const Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
