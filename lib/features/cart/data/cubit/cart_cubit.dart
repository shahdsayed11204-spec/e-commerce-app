import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:untitled3/core/network/api_error.dart';
import 'package:untitled3/core/services/cart_services.dart';
import 'package:untitled3/features/cart/data/cubit/cart_states.dart';
import 'package:untitled3/features/cart/data/model/cartmodel.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialStates());
  final CartServices cartServices = CartServices();
  CartModel? cartModel;

  Future<void> getCart() async {
    try {
      emit(GetCartLoadingStates());
      final result = await cartServices.getCart();
      cartModel = result;
      emit(GetCartSuccessStates(result));
    } catch (e) {
      if (e is ApiError) {
        emit(GetCartErrorStates(e.toString()));
      } else {
        emit(GetCartErrorStates(e.toString()));
      }
    }
  }

  Future<void> addToCart(String productId) async {
    try {
      emit(AddToCartLoadingState());

      await cartServices.addToCart(productId);
      final result = await cartServices.getCart();
      cartModel = result;
      emit(AddToCartSuccessStates(result));
    } catch (e) {
      if (e is ApiError) {
        emit(AddToCartErrorStates(e.toString()));
      } else {
        emit(AddToCartErrorStates(e.toString()));
      }
    }
  }

  Future<void> updateItem(String cartItemId, int count) async {
    try {
      emit(UpdateCartItemLoadingState());
      await cartServices.updateCart(cartItemId, count);
      final result = await cartServices.getCart();
      cartModel = result;
      emit(UpdateCartSuccessStates(result));
    } catch (e) {
      if (e is ApiError) {
        emit(UpdateCartErrorStates(e.toString()));
      } else {
        emit(UpdateCartErrorStates(e.toString()));
      }
    }
  }

  Future<void> removeItem(String cartItemId) async {
    try {
      emit(RemoveCartItemLoadingState());
      final response= await cartServices.deleteCart(cartItemId);
      final result = await cartServices.getCart();
      cartModel = result;
      emit(RemoveCartSuccessStates(result));
    } catch (e) {
      if (e is ApiError) {
        emit(RemoveCartErrorStates(e.message));
      } else {
        emit(RemoveCartErrorStates(e.toString()));
      }
    }
  }
}
