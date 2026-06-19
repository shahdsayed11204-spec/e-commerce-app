import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/features/auth/data/cubit/auth_cubit.dart';
import 'package:untitled3/features/home/data/cubit/home_cubit.dart';
import 'package:untitled3/splach_app.dart';
import 'package:untitled3/shared/bloc_observer.dart';
import 'core/constants/app_color.dart';
import 'core/network/dio_helper.dart';
import 'core/utils/cache_helper.dart';
import 'features/addresses/data/cubit/addresse_cubit.dart';
import 'features/cart/data/cubit/cart_cubit.dart';
import 'features/order/data/cubit/order_cubit.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  CacheHelper.init();
  final dioClient = DioClient();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context) =>AuthCubit()..getProfile()),
        BlocProvider(create: (context) =>HomeCubit()..getCategories()..getProducts()),
        BlocProvider(create: (context) =>CartCubit()..getCart()),
        BlocProvider(create: (context) =>AddressesCubit()..GetAddresses()),
        BlocProvider(create: (context) =>OrderCubit()..getOrder()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        ),
        home:SplachApp(),
      ),
    );
  }
}

