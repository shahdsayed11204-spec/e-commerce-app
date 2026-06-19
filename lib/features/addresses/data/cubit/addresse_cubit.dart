import 'package:bloc/bloc.dart';
import 'package:untitled3/features/addresses/data/cubit/addresse_states.dart';

import '../../../../core/services/addresses_services.dart';
import '../model/addresse_model.dart';

class AddressesCubit extends Cubit<AddressesStates> {
  AddressesCubit() : super(AddressesInitialStates());

  AddressesServices addressesServices = AddressesServices();
  List<Data>  addresseModel =[];
/// Add Addresses
  Future<void> addAddresses({
    required String name,
    required String details,
    required String phone,
    required String city,
  }) async {
    emit(AddressesAddLoadingStates());
   try{
     await addressesServices.addAddresses(
         name: name,
         details: details,
         phone: phone,
         city: city
     );
     final response = await addressesServices.getAddresses();
     addresseModel=response;
     emit(AddressesAddSuccessStates(response));
   }catch(e){
     print(e.toString());
     emit(AddressesAddErrorStates(e.toString()));
   }
  }
  /// Get Addresses
  Future<void>GetAddresses() async {
    emit(AddressesGetLoadingStates());
    try{
      final response = await addressesServices.getAddresses();
      addresseModel=response;
      emit(AddressesGetSuccessStates(response));
    }catch(e){
      emit(AddressesGetErrorStates(e.toString()));
    }
  }
 /// Delete Addresses
  Future<void> deleteAddresses(String id) async {
    emit(AddressesDeleteLoadingState(id));
    try{
      await addressesServices.deleteAddresses(id);
      final response = await addressesServices.getAddresses();
      addresseModel=response;
      emit(AddressesDeleteSuccessStates(response));
    }catch(e){
      emit(AddressesDeleteErrorStates(e.toString()));
    }
  }
}
