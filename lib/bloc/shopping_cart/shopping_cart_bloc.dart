import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/response/shopping_cart_response.dart';
import '../../model/response/shopping_cart_update_response.dart';
import '../../model/chopper/shopping_cart_service.dart';

part 'shopping_cart_event.dart';

part 'shopping_cart_state.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc() : super(ShoppingCartInitial());

  @override
  Stream<ShoppingCartState> mapEventToState(
    ShoppingCartEvent event,
  ) async* {
    yield ShoppingCartInitial();

    if (event is LoadingShoppingCart) {
      yield LoadingShoppingCartState();

      var service = ShoppingCartService.create();
      var response = await service.getShoppingCart(event.token);

      if (response.isSuccessful) {
        var shoppingCartResponse = response.body;

        yield ShoppingCartLoadedState(shoppingCartResponse);
      } else {
        yield ErrorLoadingShoppingCartState('فشل في تحميل البيانات');
      }
    } else if (event is UpdatingShoppingCart) {
      yield UpdatingShoppingCartState();

      var service = ShoppingCartService.create();
      var response = await service.updateCart({
        'token': event.token,
        'productId': event.productId,
        'quantity': event.quantity,
      });

      if (response.isSuccessful) {
        var updateResponse = response.body;

        yield ShoppingCartUpdatedState(updateResponse);
      } else {
        yield ErrorUpdatingShoppingCartState('فشل في تحديث البيانات');
      }
    }
  }
}
