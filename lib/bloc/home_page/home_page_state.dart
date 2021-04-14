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

  CategoryPageState(this.categoryId);

  @override
  List<Object> get props => [categoryId];
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
