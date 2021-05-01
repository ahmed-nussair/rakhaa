part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
}

class HomePageInitial extends HomePageState {
  @override
  List<Object> get props => [];
}

class MainPageState extends HomePageState {
  @override
  List<Object> get props => [];
}

class CategoryPageState extends HomePageState {
  final int categoryId;
  final String categoryName;

  CategoryPageState(this.categoryId, this.categoryName);

  @override
  List<Object> get props => [categoryId, categoryName];
}

class ProfilePageState extends HomePageState {
  @override
  List<Object> get props => [];
}

class OrdersHistoryPageState extends HomePageState {
  @override
  List<Object> get props => [];
}

class WishListPageState extends HomePageState {
  @override
  List<Object> get props => [];
}

class ShoppingCartPageState extends HomePageState {
  @override
  List<Object> get props => [];
}

class SigningOutState extends HomePageState {
  @override
  List<Object> get props => [];
}

class SignedOutState extends HomePageState {
  @override
  List<Object> get props => [];
}

class ErrorSigningOutState extends HomePageState {
  final String message;

  ErrorSigningOutState(this.message);

  @override
  List<Object> get props => [message];
}
