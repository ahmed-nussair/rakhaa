part of 'wish_list_bloc.dart';

abstract class WishListEvent extends Equatable {
  const WishListEvent();
}

class LoadingWishList extends WishListEvent {
  final String token;
  final int productId;

  LoadingWishList(this.token, {this.productId = -1});

  @override
  List<Object> get props => [token, productId];
}

class AddingToWishList extends WishListEvent {
  final String token;
  final int productId;

  AddingToWishList(this.token, this.productId);

  @override
  List<Object> get props => [token, productId];
}

class DeletingFromWishList extends WishListEvent {
  final String token;
  final int productId;

  DeletingFromWishList(this.token, this.productId);

  @override
  List<Object> get props => [token, productId];
}
