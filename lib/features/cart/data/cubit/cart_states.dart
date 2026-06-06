import '../model/cartmodel.dart';

abstract class CartStates {}

class CartInitialStates extends CartStates {}
/// Get Cart
class GetCartLoadingStates extends CartStates {}
class GetCartSuccessStates extends CartStates {
  final CartModel cart;

  GetCartSuccessStates(this.cart);
}
class GetCartErrorStates extends CartStates {
  final String message;

  GetCartErrorStates(this.message);
}

/// Add To Cart
class AddToCartLoadingState extends CartStates {}
class AddToCartSuccessStates extends CartStates {
  final CartModel cart;

  AddToCartSuccessStates(this.cart);
}
class AddToCartErrorStates extends CartStates {
  final String message;

  AddToCartErrorStates(this.message);
}

/// Update Cart

class UpdateCartItemLoadingState extends CartStates {}
class UpdateCartSuccessStates extends CartStates {
  final CartModel cart;

  UpdateCartSuccessStates(this.cart);
}
class UpdateCartErrorStates extends CartStates {
  final String message;

  UpdateCartErrorStates(this.message);
}

/// Remove From Cart
class RemoveCartItemLoadingState extends CartStates {}
class RemoveCartSuccessStates extends CartStates {
  final CartModel cart;

  RemoveCartSuccessStates(this.cart);
}
class RemoveCartErrorStates extends CartStates {
  final String message;

  RemoveCartErrorStates(this.message);
}

