import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../data/cubit/addresse_cubit.dart';
import '../../data/cubit/addresse_states.dart';
import '../../data/model/addresse_model.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    required this.state,
  });

  final Data address;
  final AddressesStates state;

  @override
  Widget build(BuildContext context) {
    final isDeleting =
        state is AddressesDeleteLoadingState &&
            (state as AddressesDeleteLoadingState).id == address.sId;

    return Card(
      elevation: 2,
      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F5F4),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: const Icon(
                    Icons.location_on_outlined,
                  ),
                ),

                const Gap(12),

                Expanded(
                  child: Text(
                   address.name??'',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const Gap(16),

            Text(
              address.details ?? '',
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),

            const Gap(6),

            Text(
              address.city ?? '',
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),

            const Gap(6),

            Text(
              address.phone ?? '',
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),

            const Gap(18),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},

                    icon: const Icon(Icons.edit_outlined),

                    label: const Text("Edit"),
                  ),
                ),

                const Gap(10),

                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                    ),

                    onPressed: isDeleting
                        ? null
                        : () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text(
                            "Delete Address",
                          ),

                          content: const Text(
                            "Are you sure you want to delete this address?",
                          ),

                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),

                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);

                                context
                                    .read<AddressesCubit>()
                                    .deleteAddresses(
                                  address.sId!,
                                );
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );
                    },

                    icon: isDeleting
                        ? const SizedBox(
                      width: 16,
                      height: 16,
                      child:
                      CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                        : const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),

                    label: Text(
                      isDeleting
                          ? "Deleting..."
                          : "Delete",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}