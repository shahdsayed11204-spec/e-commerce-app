abstract class CheckoutState {
  final String selectedMethod;
  final bool isPaid;
  final bool isDelivered;

  const CheckoutState({
    this.selectedMethod = 'Cash',
    this.isPaid = false,
    this.isDelivered = false,
  });
}

class CheckoutInitialStates extends CheckoutState {
  const CheckoutInitialStates() : super();
}

class CheckoutLoadingStates extends CheckoutState {
  const CheckoutLoadingStates({
    required super.selectedMethod,
    required super.isPaid,
    required super.isDelivered,
  });
}

// 3. حالة النجاح (Success)
class CheckoutSuccessStates extends CheckoutState {
  final dynamic checkoutModel; // أو اكتبي نوع الموديل بتاعك مكان dynamic

  const CheckoutSuccessStates({
    this.checkoutModel,
    required super.selectedMethod,
    required super.isPaid,
    required super.isDelivered,
  });
}

class CheckoutErrorStates extends CheckoutState {
  final String? errorMessage;

  const CheckoutErrorStates({
    this.errorMessage,
    required super.selectedMethod,
    required super.isPaid,
    required super.isDelivered,
  });
}

class CheckoutMethodChangedState extends CheckoutState {
  const CheckoutMethodChangedState({
    required super.selectedMethod,
    required super.isPaid,
    required super.isDelivered,
  });
}