import 'package:chopper/chopper.dart';

import '../response/purchased_product.dart';
import '../response/shopping_cart_response.dart';
import '../response/shopping_cart_update_response.dart';

import 'json_to_type_converter.dart';

import 'base_url.dart';

part 'shopping_cart_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class ShoppingCartService extends ChopperService {
  @Get(path: '/ShoppingCart')
  Future<Response<ShoppingCartResponse>> getShoppingCart(
      @Query('token') String token);

  @Post(path: '/ShoppingCart/AddToCart')
  @FormUrlEncodedConverter()
  Future<Response<ShoppingCartUpdateResponse>> updateCart(
      @Body() Map<String, dynamic> input);

  static ShoppingCartService create() {
    var client = ChopperClient(
      baseUrl: baseUrl,
      converter: JsonToTypeConverter({
        ShoppingCartResponse: (json) => ShoppingCartResponse.fromJson(json),
        ShoppingCartUpdateResponse: (json) =>
            ShoppingCartUpdateResponse.fromJson(json),
        PurchasedProduct: (json) => PurchasedProduct.fromJson(json),
      }),
      services: [
        _$ShoppingCartService(),
      ],
    );
    return _$ShoppingCartService(client);
  }
}
