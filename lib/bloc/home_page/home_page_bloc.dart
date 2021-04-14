import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial());

  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    yield HomePageInitial();

    if (event is NavigateToMainPage) {
      yield MainPageState();
    } else if (event is NavigateToCategoryPage) {
      yield CategoryPageState(event.categoryId);
    } else if (event is NavigateToProfilePage) {
      yield ProfilePageState();
    } else if (event is NavigateToOrdersHistoryPage) {
      yield OrdersHistoryPageState();
    } else if (event is NavigateToWishListPage) {
      yield WishListPageState();
    } else if (event is NavigateToShoppingCartPage) {
      yield ShoppingCartPageState();
    }
  }
}
