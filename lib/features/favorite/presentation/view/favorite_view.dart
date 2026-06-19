import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/data/cubit/home_cubit.dart';
import '../../data/cubit/cubit_favoite.dart';
import '../../data/cubit/state_favoite.dart';
import '../widgets/favorite_card.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Favorites",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "3 Saved Items",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),

      body: BlocBuilder<FavoritesCubit, FavoritesStates>(
        builder: (context, state) {
          final cubit = context.watch<FavoritesCubit>();
          final homeCubit = context.read<HomeCubit>();


          if (cubit.favorites.isEmpty) {
            return const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No favorite products"),
                  Icon(Icons.favorite_border),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: cubit.favorites.length,
            separatorBuilder: (context,index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final product = cubit.favorites[index];
              final productData = homeCubit.getProductById(product.id);

              if (productData == null) {
                return const SizedBox.shrink();
              }

              return FavoriteCard(
                  product: product,
                productData:productData ,
              );
            },
          );
        },
      ),
      );

  }
}