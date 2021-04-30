part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class LoadingProducts extends ProductsEvent {
  final int categoryId;
  final int subCategoryId;

  LoadingProducts(this.categoryId, {this.subCategoryId = -1});

  @override
  List<Object> get props => [categoryId, subCategoryId];
}
