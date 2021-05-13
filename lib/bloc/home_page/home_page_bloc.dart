import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/chopper/signout_service.dart';
import '../../globals.dart' as Globals;
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

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String deviceId = prefs.getString(Globals.deviceId);
      var service = SignOutService.create();
      var response = await service.signOut({
        'token': event.token,
        'deviceId': deviceId,
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
