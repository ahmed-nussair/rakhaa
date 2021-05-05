import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/response/product.dart';

import '../../model/chopper/wish_list_service.dart';

part 'wish_list_event.dart';

part 'wish_list_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListInitial());

  @override
  Stream<WishListState> mapEventToState(
    WishListEvent event,
  ) async* {
    yield WishListInitial();

    if (event is LoadingWishList) {
      yield LoadingWishListState();

      var service = WishListService.create();

      var response = await service.getWishList(event.token, event.productId);

      if (response.isSuccessful) {
        var wishListResponse = response.body;

        yield WishListLoadedState(wishListResponse);
      } else {
        yield ErrorLoadingWishListState('فشل في تحميل البيانات');
      }
    } else if (event is AddingToWishList) {
      yield AddingToWishListState();

      var service = WishListService.create();
      var response = await service
          .addToWishList({"token": event.token, "productId": event.productId});

      if (response.isSuccessful) {
        var wishListResponse = response.body;

        if (wishListResponse.result) {
          yield AddedToWishListState();
        } else {
          yield ErrorAddingToWishListState('فشل في إضافة المنتج للمفضلة');
        }
      } else {
        yield ErrorAddingToWishListState('فشل في إضافة المنتج للمفضلة');
      }
    } else if (event is DeletingFromWishList) {
      yield DeletingFromWishListState();

      var service = WishListService.create();
      var response = await service.deleteFromWishList(
          {"token": event.token, "productId": event.productId});

      if (response.isSuccessful) {
        var wishListResponse = response.body;

        if (wishListResponse.result) {
          yield DeletedFromWishListState(event.productId);
        } else {
          yield ErrorDeletingFromWishListState('فشل في حذف المنتج من المفضلة');
        }
      } else {
        yield ErrorDeletingFromWishListState('فشل في حذف المنتج من المفضلة');
      }
    }
  }
}
