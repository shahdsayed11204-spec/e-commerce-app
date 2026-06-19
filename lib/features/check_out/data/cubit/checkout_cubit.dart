import 'package:bloc/bloc.dart';
import 'package:untitled3/core/services/check_out_services.dart';
import 'package:untitled3/features/check_out/data/cubit/checkout_state.dart';
import 'package:untitled3/features/check_out/data/model/check_out_model.dart';

class CheckoutCubit extends Cubit<CheckoutState>{
  CheckoutCubit():super(CheckoutInitialStates());

  CheckOutServices checkOutServices=CheckOutServices();

  CheckOutModel?checkOutModel;

  String selectedMethod = 'Cash';
  bool isPaid = false;
  bool isDelivered = false;

  void changePaymentMethod(String method) {
    selectedMethod = method;
    emit(CheckoutMethodChangedState(
      selectedMethod: selectedMethod,
      isPaid: isPaid,
      isDelivered: isDelivered,
    ));  }
  Future<void>createCashOrder({required String cartId,required Map<String,dynamic> shippingAddress,required String token})async {
    try {
      emit(CheckoutLoadingStates(
        selectedMethod: selectedMethod,
        isPaid: isPaid,
        isDelivered: isDelivered,
      ));
      final result = await checkOutServices.createCashOrder(
      cartId,  shippingAddress, token);
      checkOutModel = result;
      emit(CheckoutSuccessStates(
        checkoutModel: result,
        selectedMethod: selectedMethod,
        isPaid: isPaid,
        isDelivered: isDelivered,
      ));
    } catch (e) {
      emit(CheckoutErrorStates(
        errorMessage: e.toString(),
        selectedMethod: selectedMethod,
        isPaid: isPaid,
        isDelivered: isDelivered,
      ));
    }
  }
  // Future<void> createVisaOrder({
  //   required String cartId,
  //   required Map<String, dynamic> shippingAddress,
  //   required String token,
  // }) async {
  //   try {
  //     emit(CheckoutLoadingStates());
  //
  //     final url = await checkOutServices.createVisaOrder(
  //         cartId: cartId, shippingAddress: shippingAddress, token: token);
  //
  //
  //     if (url != null) {
  //       emit(CheckoutSuccessStates(visaUrl: url));
  //     } else {
  //       emit(CheckoutErrorStates("Failed to get payment URL from server"));
  //     }
  //   } catch (e) {
  //     emit(CheckoutErrorStates(e.toString()));
  //   }
  // }
}