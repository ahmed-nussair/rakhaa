import 'package:chopper/chopper.dart';
import 'package:rakhaa/model/response/governorate.dart';
import '../response/address.dart';
import '../response/address_adding_response.dart';
import '../response/address_updating_response.dart';
import '../response/address_deleting_response.dart';
import '../response/governorate.dart';
import '../response/city.dart';

import 'json_to_type_converter.dart';

import 'base_url.dart';

part 'addresses_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class AddressesService extends ChopperService {
  @Get(path: '/Addresses')
  Future<Response<List<Address>>> getAddresses(@Query('token') String token);

  @Post(path: '/Addresses/AddAddress')
  @FormUrlEncodedConverter()
  Future<Response<AddressAddingResponse>> addAddress(
      @Body() Map<String, dynamic> input);

  @Put(path: '/Addresses/UpdateAddress')
  @FormUrlEncodedConverter()
  Future<Response<AddressUpdatingResponse>> updateAddress(
      @Body() Map<String, dynamic> input);

  @Delete(path: '/Addresses/DeleteAddress')
  @FormUrlEncodedConverter()
  Future<Response<AddressDeletingResponse>> deleteAddress(
      @Field('token') String token, @Field('addressId') int addressId);

  @Get(path: '/Addresses/Governorates')
  Future<Response<List<Governorate>>> getGovernorates();

  @Get(path: '/Addresses/Cities')
  Future<Response<List<City>>> getCities(
      @Query('governorateId') int governorateId);

  static AddressesService create() {
    var client = ChopperClient(
      baseUrl: baseUrl,
      converter: JsonToTypeConverter({
        Address: (json) => Address.fromJson(json),
        AddressAddingResponse: (json) => AddressAddingResponse.fromJson(json),
        AddressUpdatingResponse: (json) =>
            AddressUpdatingResponse.fromJson(json),
        AddressDeletingResponse: (json) =>
            AddressDeletingResponse.fromJson(json),
        Governorate: (json) => Governorate.fromJson(json),
        City: (json) => City.fromJson(json),
      }),
      services: [
        _$AddressesService(),
      ],
    );
    return _$AddressesService(client);
  }
}
