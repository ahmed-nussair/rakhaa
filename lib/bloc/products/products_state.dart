part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

class LoadingProductsState extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoadedState extends ProductsState {
  final List<Product> products;

  ProductsLoadedState(this.products);

  @override
  List<Object> get props => [products];
}

class ErrorLoadingProductsState extends ProductsState {
  final String message;

  ErrorLoadingProductsState(this.message);

  @override
  List<Object> get props => [message];
}
