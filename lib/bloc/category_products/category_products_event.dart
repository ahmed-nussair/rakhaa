part of 'category_products_bloc.dart';

abstract class CategoryProductsEvent extends Equatable {
  const CategoryProductsEvent();
}

class LoadingSubCategories extends CategoryProductsEvent {
  final int categoryId;

  LoadingSubCategories(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

abstract class LoadingProducts extends CategoryProductsEvent {
  final int categoryId;

  LoadingProducts(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class LoadingAllProducts extends LoadingProducts {
  final int categoryId;

  LoadingAllProducts(this.categoryId) : super(categoryId);

  @override
  List<Object> get props => [];
}

class LoadingProductsOfSubCategory extends LoadingProducts {
  final int categoryId;
  final int subCategoryId;

  LoadingProductsOfSubCategory(this.categoryId, this.subCategoryId)
      : super(categoryId);

  @override
  List<Object> get props => [subCategoryId];
}
