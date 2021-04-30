import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/response/product.dart';
import '../../model/chopper/products_service.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial());

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    yield ProductsInitial();

    if (event is LoadingProducts) {
      yield LoadingProductsState();

      var service = ProductsService.create();
      var response = await service.getProducts(event.categoryId,
          subCategoryId: event.subCategoryId);

      if (response.isSuccessful) {
        var productsResponse = response.body;
        yield ProductsLoadedState(productsResponse);
      } else {
        yield ErrorLoadingProductsState("فشل في تحميل بيانات الأصناف");
      }
    }
  }
}
