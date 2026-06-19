import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:untitled3/shared/custom_text/custom_snackbar.dart';
import '../../data/cubit/addresse_cubit.dart';
import '../../data/cubit/addresse_states.dart';
import '../widets/address_card.dart';

class AddressesView extends StatelessWidget {

  final nameController = TextEditingController();
  final detailsController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressesCubit, AddressesStates>(
      listener: (context, state) {
        if (state is AddressesAddSuccessStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnack(
              msg: 'Address Added Successfully',
              icon: Icons.check,
              color: Colors.green,
            ),
          );
        }
        if (state is AddressesAddErrorStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnack(msg: state.message),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AddressesCubit>();
        return Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          appBar:AppBar(
            title: const Text('My Addresses') ,
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Colors.black87,
                )
            ),
          ) ,
          body: Builder(
            builder: (context) {
              if (state is AddressesGetLoadingStates &&
                  cubit.addresseModel.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is AddressesGetErrorStates &&
                  cubit.addresseModel.isEmpty) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (cubit.addresseModel.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_off_outlined,
                        size: 80,
                        color: Colors.grey.shade400,
                      ),
                      const Gap(16),
                      const Text(
                        'No addresses found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        'Add your first address',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  await cubit.GetAddresses();
                },
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 10,
                    bottom: 90,
                  ),
                  itemCount: cubit.addresseModel.length,
                  separatorBuilder: (content, index) => const Gap(12),
                  itemBuilder: (context, index) {
                    return AddressCard(
                      address: cubit.addresseModel[index],
                      state: state,
                    );
                  },
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (sheetContext) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 20,
                      bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        const Text(
                          "Add Address",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Gap(20),

                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Address Name",
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const Gap(12),

                        TextFormField(
                          controller: detailsController,
                          decoration: const InputDecoration(
                            labelText: "Details",
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const Gap(12),

                        TextFormField(
                          controller: cityController,
                          decoration: const InputDecoration(
                            labelText: "City",
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const Gap(12),

                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "Phone",
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const Gap(20),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<AddressesCubit>().addAddresses(
                                name: nameController.text,
                                details: detailsController.text,
                                phone: phoneController.text,
                                city: cityController.text,
                              );

                              Navigator.pop(sheetContext);
                            },
                            child: const Text("Save Address"),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Address"),
          ),
        );
      },
    );
  }
}