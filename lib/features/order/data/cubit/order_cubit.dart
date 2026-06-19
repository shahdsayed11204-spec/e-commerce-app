import 'package:bloc/bloc.dart';
import 'package:untitled3/features/order/data/model/cartI_tems_model.dart';

import '../../../../core/services/order_services.dart';
import 'order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(OrderInitialStates());

  final OrderServices orderServices = OrderServices();


  Future<void> getOrder() async {
    emit(OrderLoadingStates());

    try {
      final response = await orderServices.getOrder();

      emit(OrderSuccessStates(response.cast<DataCartItem>()));
    } catch (e) {
      print(e.toString());
      emit(OrderErrorStates(e.toString()));
    }
  }
}