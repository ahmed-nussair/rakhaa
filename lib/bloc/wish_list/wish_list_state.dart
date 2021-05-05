part of 'wish_list_bloc.dart';

abstract class WishListState extends Equatable {
  const WishListState();
}

class WishListInitial extends WishListState {
  @override
  List<Object> get props => [];
}

class LoadingWishListState extends WishListState {
  @override
  List<Object> get props => [];
}

class WishListLoadedState extends WishListState {
  final List<Product> products;

  WishListLoadedState(this.products);

  @override
  List<Object> get props => [products];
}

class ErrorLoadingWishListState extends WishListState {
  final String message;

  ErrorLoadingWishListState(this.message);

  @override
  List<Object> get props => [message];
}

class AddingToWishListState extends WishListState {
  @override
  List<Object> get props => [];
}

class AddedToWishListState extends WishListState {
  @override
  List<Object> get props => [];
}

class ErrorAddingToWishListState extends WishListState {
  final String message;

  ErrorAddingToWishListState(this.message);

  @override
  List<Object> get props => [message];
}

class DeletingFromWishListState extends WishListState {
  @override
  List<Object> get props => [];
}

class DeletedFromWishListState extends WishListState {
  final int productId;

  DeletedFromWishListState(this.productId);

  @override
  List<Object> get props => [productId];
}

class ErrorDeletingFromWishListState extends WishListState {
  final String message;

  ErrorDeletingFromWishListState(this.message);

  @override
  List<Object> get props => [message];
}
