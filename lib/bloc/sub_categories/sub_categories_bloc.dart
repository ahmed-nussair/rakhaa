import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/chopper/products_service.dart';
import '../../model/response/subcategory.dart';

part 'sub_categories_event.dart';

part 'sub_categories_state.dart';

class SubCategoriesBloc extends Bloc<SubCategoriesEvent, SubCategoriesState> {
  SubCategoriesBloc() : super(SubCategoriesInitial());

  @override
  Stream<SubCategoriesState> mapEventToState(
    SubCategoriesEvent event,
  ) async* {
    yield SubCategoriesInitial();

    if (event is LoadingSubCategories) {
      yield LoadingSubCategoriesState();

      var service = ProductsService.create();

      var response = await service.getSubCategories(event.categoryId);

      if (response.isSuccessful) {
        var subCategoriesResponse = response.body;

        yield SubCategoriesLoadedState(subCategoriesResponse);
      } else {
        yield ErrorLoadingSubCategoriesState("فشل في تحميل البيانات");
      }
    }
  }
}
