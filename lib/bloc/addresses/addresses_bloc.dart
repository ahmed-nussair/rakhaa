import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/response/address.dart';
import '../../model/response/governorate.dart';
import '../../model/response/city.dart';
import '../../model/response/address_adding_response.dart';
import '../../model/response/address_deleting_response.dart';
import '../../model/response/address_updating_response.dart';

import '../../model/chopper/addresses_service.dart';

part 'addresses_event.dart';

part 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  AddressesBloc() : super(AddressesInitial());

  @override
  Stream<AddressesState> mapEventToState(
    AddressesEvent event,
  ) async* {
    yield AddressesInitial();

    if (event is LoadingAddresses) {
      yield LoadingAddressesState();

      var service = AddressesService.create();
      var response = await service.getAddresses(event.token);

      if (response.isSuccessful) {
        var addressesResponse = response.body;

        yield AddressesLoadedState(addressesResponse);
      } else {
        yield ErrorLoadingAddresses('فشل في تحميل العناوين');
      }
    } else if (event is AddingAddress) {
      yield AddingAddressState();

      var service = AddressesService.create();
      var response = await service.addAddress(event.input);

      if (response.isSuccessful) {
        var addingAddressResponse = response.body;

        yield AddressAddedState(addingAddressResponse);
      } else {
        print(response.error.toString());
        print(response.bodyString);
        yield ErrorAddingAddress('فشل في إضافة عنوان جديد');
      }
    } else if (event is UpdatingAddress) {
      yield UpdatingAddressState();

      var service = AddressesService.create();
      var response = await service.updateAddress(event.input);

      if (response.isSuccessful) {
        var updatingAddressResponse = response.body;

        yield AddressUpdatedState(updatingAddressResponse);
      } else {
        yield ErrorAddingAddress('فشل في تحديث العنوان');
      }
    } else if (event is DeletingAddress) {
      yield DeletingAddressState();

      var service = AddressesService.create();
      var response = await service.deleteAddress(event.token, event.addressId);

      if (response.isSuccessful) {
        var deletingAddressResponse = response.body;

        yield AddressDeletedState(deletingAddressResponse);
      } else {
        yield ErrorAddingAddress('فشل في حذف العنوان');
      }
    } else if (event is LoadingGovernorates) {
      yield LoadingGovernoratesState();

      var service = AddressesService.create();
      var response = await service.getGovernorates();

      if (response.isSuccessful) {
        var governoratesResponse = response.body;

        yield GovernoratesLoadedState(governoratesResponse);
      } else {
        yield ErrorLoadingGovernoratesState('فشل في تحميل المحافظات');
      }
    } else if (event is LoadingCities) {
      yield LoadingCitiesState();

      var service = AddressesService.create();
      var response = await service.getCities(event.governorateId);

      if (response.isSuccessful) {
        var citiesResponse = response.body;

        yield CitiesLoadedState(citiesResponse);
      } else {
        yield ErrorLoadingCitiesState('فشل في تحميل البيانات');
      }
    }
  }
}
