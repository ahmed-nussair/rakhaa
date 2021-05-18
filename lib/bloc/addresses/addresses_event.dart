part of 'addresses_bloc.dart';

abstract class AddressesEvent extends Equatable {
  const AddressesEvent();
}

class LoadingAddresses extends AddressesEvent {
  final String token;

  LoadingAddresses(this.token);

  @override
  List<Object> get props => [token];
}

class AddingAddress extends AddressesEvent {
  final Map<String, dynamic> input;

  AddingAddress(this.input);

  @override
  List<Object> get props => [input];
}

class UpdatingAddress extends AddressesEvent {
  final Map<String, dynamic> input;

  UpdatingAddress(this.input);

  @override
  List<Object> get props => [input];
}

class DeletingAddress extends AddressesEvent {
  final String token;
  final int addressId;

  DeletingAddress(this.token, this.addressId);

  @override
  List<Object> get props => [token, addressId];
}

class LoadingGovernorates extends AddressesEvent {
  @override
  List<Object> get props => [];
}

class LoadingCities extends AddressesEvent {
  final int governorateId;

  LoadingCities(this.governorateId);

  @override
  List<Object> get props => [governorateId];
}
