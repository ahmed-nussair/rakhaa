import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/response/subcategory.dart';
import '../../model/response/product.dart';
import '../../model/chopper/products_service.dart';

part 'category_products_event.dart';

part 'category_products_state.dart';

class CategoryProductsBloc
    extends Bloc<CategoryProductsEvent, CategoryProductsState> {
  CategoryProductsBloc() : super(CategoryProductsInitial());

  @override
  Stream<CategoryProductsState> mapEventToState(
    CategoryProductsEvent event,
  ) async* {
    yield CategoryProductsInitial();

    if (event is LoadingSubCategories) {
      yield LoadingSubCategoriesState();

      var service = ProductsService.create();

      var response = await service.getSubCategories(event.categoryId);

      if (response.isSuccessful) {
        var subCategoriesResponse = response.body;

        yield SubCategoriesLoadedState(subCategoriesResponse);
      } else {
        yield ErrorLoadingSubCategoriesState('فشل في تحميل البيانات');
      }
    } else if (event is LoadingProducts) {
      yield LoadingProductsState();

      var service = ProductsService.create();

      var response = await service.getProducts(event.categoryId,
          subCategoryId:
              event is LoadingProductsOfSubCategory ? event.subCategoryId : -1);

      if (response.isSuccessful) {
        var productsResponse = response.body;

        yield ProductsLoadedState(productsResponse);
      } else {
        yield ErrorLoadingProductsState('فشل في تحميل بيانات المنتجات');
      }
    }
  }
}
