import 'package:untitled3/features/addresses/data/model/addresse_model.dart';

abstract class AddressesStates {}

class AddressesInitialStates extends AddressesStates{}
/// Add Addresses
class AddressesAddLoadingStates extends AddressesStates{}
class AddressesAddSuccessStates extends AddressesStates{
  final List <Data> addresseModel;

  AddressesAddSuccessStates(this.addresseModel);
}
class AddressesAddErrorStates extends AddressesStates{

  final String message;
  AddressesAddErrorStates(this.message);
}
/// Get Addresses
class AddressesGetLoadingStates extends AddressesStates{}
class AddressesGetSuccessStates extends AddressesStates{
  final List <Data> addresseModel;

  AddressesGetSuccessStates(this.addresseModel);
}
class AddressesGetErrorStates extends AddressesStates{

  final String message;
  AddressesGetErrorStates(this.message);
}

/// Delete Addresses
class AddressesDeleteLoadingState extends AddressesStates {
  final String id;

  AddressesDeleteLoadingState(this.id);
}
class AddressesDeleteSuccessStates extends AddressesStates {
  final List <Data> addresseModel;

  AddressesDeleteSuccessStates(this.addresseModel);


}
class AddressesDeleteErrorStates extends AddressesStates {
  final String message;

  AddressesDeleteErrorStates(this.message);
}




