part of 'category_products_bloc.dart';

abstract class CategoryProductsState extends Equatable {
  const CategoryProductsState();
}

class CategoryProductsInitial extends CategoryProductsState {
  @override
  List<Object> get props => [];
}

class LoadingSubCategoriesState extends CategoryProductsState {
  @override
  List<Object> get props => [];
}

class SubCategoriesLoadedState extends CategoryProductsState {
  final List<SubCategory> subCategories;

  SubCategoriesLoadedState(this.subCategories);

  @override
  List<Object> get props => [subCategories];
}

class ErrorLoadingSubCategoriesState extends CategoryProductsState {
  final String message;

  ErrorLoadingSubCategoriesState(this.message);

  @override
  List<Object> get props => [message];
}

class LoadingProductsState extends CategoryProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoadedState extends CategoryProductsState {
  final List<Product> products;

  ProductsLoadedState(this.products);

  @override
  List<Object> get props => [products];
}

class ErrorLoadingProductsState extends CategoryProductsState {
  final String message;

  ErrorLoadingProductsState(this.message);

  @override
  List<Object> get props => [message];
}
