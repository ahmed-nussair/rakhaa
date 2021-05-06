import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/response/product.dart';
import '../../model/chopper/products_service.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    yield SearchInitial();

    if (event is Searching) {
      yield SearchingState();

      var service = ProductsService.create();

      var response = await service.search(event.keyword);

      if (response.isSuccessful) {
        var result = response.body;

        yield SearchedState(result);
      } else {
        yield ErrorSearchingState('فشل في محاولة البحث');
      }
    }
  }
}
