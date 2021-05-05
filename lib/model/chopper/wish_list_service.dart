import 'package:chopper/chopper.dart';
import '../response/wish_list_response.dart';
import '../response/product.dart';

import 'json_to_type_converter.dart';

import 'base_url.dart';

part 'wish_list_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class WishListService extends ChopperService {
  @Get(path: '/WishList')
  Future<Response<List<Product>>> getWishList(
      @Query('token') String token, @Query('productId') int productId);

  @Post(path: '/WishList/AddToWishList')
  @FormUrlEncodedConverter()
  Future<Response<WishListResponse>> addToWishList(
      @Body() Map<String, dynamic> input);

  @Delete(path: '/WishList/DeleteFromWishList')
  @FormUrlEncodedConverter()
  Future<Response<WishListResponse>> deleteFromWishList(
      @Body() Map<String, dynamic> input);

  static WishListService create() {
    var client = ChopperClient(
      baseUrl: baseUrl,
      converter: JsonToTypeConverter(
        {
          WishListResponse: (json) => WishListResponse.fromJson(json),
          Product: (json) => Product.fromJson(json),
        },
      ),
      services: [
        _$WishListService(),
      ],
    );
    return _$WishListService(client);
  }
}
