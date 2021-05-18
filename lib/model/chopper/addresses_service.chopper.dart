// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addresses_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$AddressesService extends AddressesService {
  _$AddressesService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = AddressesService;

  Future<Response<List<Address>>> getAddresses(String token) {
    final $url = '/api/Addresses';
    final Map<String, dynamic> $params = {'token': token};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Address>, Address>($request);
  }

  Future<Response<AddressAddingResponse>> addAddress(
      Map<String, dynamic> input) {
    final $url = '/api/Addresses/AddAddress';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<AddressAddingResponse, AddressAddingResponse>($request);
  }

  Future<Response<AddressUpdatingResponse>> updateAddress(
      Map<String, dynamic> input) {
    final $url = '/api/Addresses/UpdateAddress';
    final $body = input;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client
        .send<AddressUpdatingResponse, AddressUpdatingResponse>($request);
  }

  Future<Response<AddressDeletingResponse>> deleteAddress(
      String token, int addressId) {
    final $url = '/api/Addresses/DeleteAddress';
    final $body = {'token': token, 'addressId': addressId};
    final $request = Request('DELETE', $url, client.baseUrl, body: $body);
    return client
        .send<AddressDeletingResponse, AddressDeletingResponse>($request);
  }

  Future<Response<List<Governorate>>> getGovernorates() {
    final $url = '/api/Addresses/Governorates';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<Governorate>, Governorate>($request);
  }

  Future<Response<List<City>>> getCities(int governorateId) {
    final $url = '/api/Addresses/Cities';
    final Map<String, dynamic> $params = {'governorateId': governorateId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<City>, City>($request);
  }
}
