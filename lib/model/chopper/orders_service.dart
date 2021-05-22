import 'package:chopper/chopper.dart';
import '../response/order.dart';
import '../response/order_status.dart';
import '../response/order_response.dart';
import '../response/purchased_product.dart';

import 'json_to_type_converter.dart';

import 'base_url.dart';

part 'orders_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class OrdersService extends ChopperService {
  @Get(path: '/Orders')
  Future<Response<List<Order>>> getOrders(@Query('token') String token);

  @Get(path: '/Orders/{orderId}')
  Future<Response<Order>> getOrder(
      @Query('token') String token, @Path('orderId') int orderId);

  @Post(path: '/Orders/AddOrder')
  @FormUrlEncodedConverter()
  Future<Response<OrderResponse>> addOrder(
    @Field('token') String token,
    @Field('addressId') int addressId,
    @Field('cartId') int cartId,
    @Field('dateTime') String dateTime,
  );

  static OrdersService create() {
    var client = ChopperClient(
      baseUrl: baseUrl,
      converter: JsonToTypeConverter({
        OrderResponse: (json) => OrderResponse.fromJson(json),
        Order: (json) => Order.fromJson(json),
        OrderStatus: (json) => OrderStatus.fromJson(json),
        PurchasedProduct: (json) => PurchasedProduct.fromJson(json),
      }),
      services: [
        _$OrdersService(),
      ],
    );
    return _$OrdersService(client);
  }
}
