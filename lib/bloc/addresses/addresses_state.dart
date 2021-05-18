part of 'addresses_bloc.dart';

abstract class AddressesState extends Equatable {
  const AddressesState();
}

class AddressesInitial extends AddressesState {
  @override
  List<Object> get props => [];
}

class LoadingAddressesState extends AddressesState {
  @override
  List<Object> get props => [];
}

class AddressesLoadedState extends AddressesState {
  final List<Address> addresses;

  AddressesLoadedState(this.addresses);

  @override
  List<Object> get props => [addresses];
}

class ErrorLoadingAddresses extends AddressesState {
  final String message;

  ErrorLoadingAddresses(this.message);

  @override
  List<Object> get props => [message];
}

class AddingAddressState extends AddressesState {
  @override
  List<Object> get props => [];
}

class AddressAddedState extends AddressesState {
  final AddressAddingResponse response;

  AddressAddedState(this.response);

  @override
  List<Object> get props => [response];
}

class ErrorAddingAddress extends AddressesState {
  final String message;

  ErrorAddingAddress(this.message);

  @override
  List<Object> get props => [message];
}

class UpdatingAddressState extends AddressesState {
  @override
  List<Object> get props => [];
}

class AddressUpdatedState extends AddressesState {
  final AddressUpdatingResponse response;

  AddressUpdatedState(this.response);

  @override
  List<Object> get props => [response];
}

class ErrorUpdatingAddress extends AddressesState {
  final String message;

  ErrorUpdatingAddress(this.message);

  @override
  List<Object> get props => [message];
}

class DeletingAddressState extends AddressesState {
  @override
  List<Object> get props => [];
}

class AddressDeletedState extends AddressesState {
  final AddressDeletingResponse response;

  AddressDeletedState(this.response);

  @override
  List<Object> get props => [response];
}

class ErrorDeletingAddress extends AddressesState {
  final String message;

  ErrorDeletingAddress(this.message);

  @override
  List<Object> get props => [message];
}

class LoadingGovernoratesState extends AddressesState {
  @override
  List<Object> get props => [];
}

class GovernoratesLoadedState extends AddressesState {
  final List<Governorate> governorates;

  GovernoratesLoadedState(this.governorates);

  @override
  List<Object> get props => [governorates];
}

class ErrorLoadingGovernoratesState extends AddressesState {
  final String message;

  ErrorLoadingGovernoratesState(this.message);

  @override
  List<Object> get props => [message];
}

class LoadingCitiesState extends AddressesState {
  @override
  List<Object> get props => [];
}

class CitiesLoadedState extends AddressesState {
  final List<City> cities;

  CitiesLoadedState(this.cities);

  @override
  List<Object> get props => [cities];
}

class ErrorLoadingCitiesState extends AddressesState {
  final String message;

  ErrorLoadingCitiesState(this.message);

  @override
  List<Object> get props => [message];
}
