import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/chopper/signout_service.dart';
// import '../../model/response/signout_response.dart';

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
      yield CategoryPageState(event.categoryId, event.categoryName);
    } else if (event is NavigateToProfilePage) {
      yield ProfilePageState();
    } else if (event is NavigateToOrdersHistoryPage) {
      yield OrdersHistoryPageState();
    } else if (event is NavigateToWishListPage) {
      yield WishListPageState();
    } else if (event is NavigateToShoppingCartPage) {
      yield ShoppingCartPageState();
    } else if (event is NavigateToSearchResult) {
      yield SearchResultState(event.keyword);
    } else if (event is SignOut) {
      yield SigningOutState();

      var service = SignOutService.create();
      var response = await service.signOut({
        'token': event.token,
      });

      print(response.bodyString);
      if (response.isSuccessful) {
        var signOutResponse = response.body;

        if (signOutResponse.result) {
          yield SignedOutState();
        } else {
          yield ErrorSigningOutState("فشل في تسجيل الخروج");
        }
      } else {
        yield ErrorSigningOutState("فشل في تسجيل الخروج");
      }
    }
  }
}
