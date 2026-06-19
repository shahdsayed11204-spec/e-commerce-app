import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/core/constants/cahce_key.dart';
import 'package:untitled3/features/check_out/presentation/widgets/price_row.dart';
import 'package:untitled3/shared/custom_text/coustom_taxt.dart';
import '../../../../shared/custom_text/custom_bottom_cart.dart';
import '../../../../shared/custom_text/custom_snackbar.dart';
import '../../data/cubit/checkout_cubit.dart';
import '../../data/cubit/checkout_state.dart';
import '../widgets/box_decoration.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({
    super.key,
    required this.cartId,
    required this.totalCartPrice,
  });

  final String cartId;
  final int totalCartPrice;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {

  bool isOrderCreated = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xffF9F9F9),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: Colors.black87,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Checkout",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            final cubit = context.read<CheckoutCubit>();
            return SingleChildScrollView(
              physics:  BouncingScrollPhysics(),
              padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: "Shipping Address"),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: boxDecoration(),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xff2194EF).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.location_on_rounded,
                            color: Color(0xff2194EF),
                            size: 22,
                          ),
                        ),
                        const Gap(14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: cubit.checkOutModel?.data?.shippingAddress?.city ??
                                    "Cairo",
                                font: FontWeight.bold,
                                size: 15,
                              ),
                              const Gap(4),
                              CustomText(text:
                              cubit.checkOutModel?.data?.shippingAddress?.details ??
                                  "Main Street",
                                color: Colors.grey.shade600,
                                size: 13,

                              ) ,
                              const Gap(4),
                              CustomText(text:
                              cubit.checkOutModel?.data?.shippingAddress?.phone ??
                                  "01000000000",
                                color: Colors.grey.shade600,
                                size: 13,

                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(24),
                  CustomText(text: "Payment Method"),
                  const Gap(10),
                  Column(
                    children: [
                      _buildPaymentOption(
                        context: context,
                        state: state,
                        id: 'Cash',
                        title: 'Cash On Delivery',
                        subtitle: 'Pay when you receive your order',
                        icon: CupertinoIcons.money_dollar_circle,
                      ),
                      const Gap(12),
                      _buildPaymentOption(
                        context: context,
                        state: state,
                        id: 'Visa',
                        title: 'Debit / Credit Card',
                        subtitle: 'Click to pay online via Visa',
                        icon: CupertinoIcons.creditcard,
                      ),
                    ],
                  ),
                  const Gap(24),
                  CustomText(text: "Order Summary"),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: boxDecoration(),
                    child: Column(
                      children: [
                        PriceRow(title: "Subtotal", value: "${widget.totalCartPrice} EGP"),
                        const Gap(12),
                        PriceRow(title: "Shipping", value: "0.00 EGP"),
                        const Gap(12),
                        PriceRow(title: "Tax", value: "0.00 EGP"),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1, color: Color(0xFFEFEFEF)),
                        ),
                        PriceRow(
                          title: "Total Price",
                          value: "${widget.totalCartPrice} EGP",
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),

                  if (isOrderCreated) ...[
                    const Gap(24),
                    CustomText(text: "Order Tracking"),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: boxDecoration().copyWith(
                        border: Border.all(color: const Color(0xff2194EF).withOpacity(0.1)),
                      ),
                      child: Column(
                        children: [
                          _buildModernStatusRow(
                            isActive: state.isPaid,
                            title: 'Payment Status',
                            activeText: 'Paid Success',
                            inactiveText: 'Pending Payment',
                            icon: state.isPaid ? Icons.check_circle_rounded : Icons.pending_actions_rounded,
                            color: state.isPaid ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(height: 1, color: Color(0xFFF1F1F1)),
                          ),
                          _buildModernStatusRow(
                            isActive: state.isDelivered,
                            title: 'Delivery Status',
                            activeText: 'Delivered',
                            inactiveText: 'In Progress',
                            icon: state.isDelivered ? Icons.local_shipping_rounded : Icons.timer_outlined,
                            color: state.isDelivered ? const Color(0xFF2E7D32) : const Color(0xFFEF6C00),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutSuccessStates) {
              setState(() {
                isOrderCreated = true;
              });
              _showSuccessDialog(context);
            } else if (state is CheckoutErrorStates) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment Canceled or Failed!'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final bool isLoading = state is CheckoutLoadingStates;
            if (isOrderCreated) return const SizedBox.shrink();
            final product=context.read<CheckoutCubit>().checkOutModel;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 58,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isLoading
                                ? [const Color(0xff1076c5), const Color(0xff2194EF)]
                                : [const Color(0xff2194EF), const Color(0xff4facfe)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff2194EF).withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: isLoading ? null : () {
                              String? token = CacheKeys.token;
                              if (token == null || token.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    customSnack(msg:
                                    'Please login again! '
                                    )
                                );
                                return;
                              }

                              Map<String, dynamic> shippingData = {
                                "details": "Main Street, Building 12",
                                "phone": "01010800921",
                                "city": "Cairo"
                              };

                              if (context.read<CheckoutCubit>().selectedMethod == 'Cash') {
                                BlocProvider.of<CheckoutCubit>(context).createCashOrder(
                                  cartId: widget.cartId,
                                  shippingAddress: shippingData,
                                  token: token,
                                );
                              }
                            },
                            child: Center(
                              child: isLoading
                                  ? const CupertinoActivityIndicator(color: Colors.white)
                                  : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Place Order",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Gap(8),
                                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 170),
            child: Container(
              width: 500,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Color(0xff2194EF),
                    child: Icon(
                      CupertinoIcons.check_mark,
                      size: 55,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(10),
                  CustomText(
                    text: 'Success !',
                    color: const Color(0xff2194EF),
                    size: 25,
                    font: FontWeight.bold,
                  ),
                  CustomText(
                    text: 'Your payment was successful.\n'
                        'A receipt for this purchase has \n'
                        ' been sent to your email',
                    color: const Color(0xff808080),
                    size: 14,
                  ),
                  const Gap(15),
                  CustomBottomCart(
                    width: 200,
                    height: 50,
                    text: 'Go Back',
                    onTap: () {
                      Navigator.pop(context);
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

  Widget _buildPaymentOption({
    required BuildContext context,
    required CheckoutState state,
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final bool isSelected = state.selectedMethod == id;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? const Color(0xff2194EF) : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        onTap: () {
          context.read<CheckoutCubit>().changePaymentMethod(id);
        },
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xff2194EF) : Colors.grey.shade500,
          size: 24,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        ),
        trailing: Radio<String>(
          activeColor: const Color(0xff2194EF),
          value: id,
          groupValue: state.selectedMethod,
          onChanged: (value) {
            context.read<CheckoutCubit>().changePaymentMethod(value!);
          },
        ),
      ),
    );
  }

  Widget _buildModernStatusRow({
    required bool isActive,
    required String title,
    required String activeText,
    required String inactiveText,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const Gap(12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            isActive ? activeText : inactiveText,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}