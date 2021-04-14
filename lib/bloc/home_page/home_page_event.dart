part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class NavigateToMainPage extends HomePageEvent {
  @override
  List<Object> get props => [];
}

class NavigateToCategoryPage extends HomePageEvent {
  final int categoryId;

  NavigateToCategoryPage(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class NavigateToProfilePage extends HomePageEvent {
  @override
  List<Object> get props => [];
}

class NavigateToOrdersHistoryPage extends HomePageEvent {
  @override
  List<Object> get props => [];
}

class NavigateToWishListPage extends HomePageEvent {
  @override
  List<Object> get props => [];
}

class NavigateToShoppingCartPage extends HomePageEvent {
  @override
  List<Object> get props => [];
}
