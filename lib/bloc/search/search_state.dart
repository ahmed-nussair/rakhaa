part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchingState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchedState extends SearchState {
  final List<Product> products;

  SearchedState(this.products);

  @override
  List<Object> get props => [products];
}

class ErrorSearchingState extends SearchState {
  final String message;

  ErrorSearchingState(this.message);

  @override
  List<Object> get props => [message];
}
