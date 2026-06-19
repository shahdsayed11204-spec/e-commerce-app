import 'package:untitled3/features/order/data/model/cartI_tems_model.dart';


abstract class OrderStates {}

class OrderInitialStates extends OrderStates {}

class OrderLoadingStates extends OrderStates {}

class OrderSuccessStates extends OrderStates {
  final List<DataCartItem> cart;

  OrderSuccessStates(this.cart);
}

class OrderErrorStates extends OrderStates {
  final String error;

  OrderErrorStates(this.error);

}