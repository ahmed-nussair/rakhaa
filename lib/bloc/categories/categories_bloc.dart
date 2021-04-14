import 'dart:async';

import '../../model/chopper/products_service.dart';
import '../../model/response/category.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    yield CategoriesInitial();

    var service = ProductsService.create();

    if (event is LoadingCategories) {
      yield LoadingCategoriesState();

      var response = await service.getCategories();

      if (response.isSuccessful) {
        var categoriesResponse = response.body;

        yield CategoriesLoadedState(categoriesResponse);
      } else {
        yield ErrorLoadingCategoriesState("فشل في تحميل فئات الأصناف!");
      }
    } else if (event is LoadCategory) {
      yield LoadingCategoryState();

      var response = await service.getCategory(event.categoryId);

      if (response.isSuccessful) {
        var categoryResponse = response.body;

        yield CategoryLoadedState(categoryResponse);
      } else {
        yield ErrorLoadingCategoryState("فشل في تحميل بيانات فئة الأصناف!");
      }
    }
  }
}
