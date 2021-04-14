part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

class LoadingCategoriesState extends CategoriesState {
  @override
  List<Object> get props => [];
}

class LoadingCategoryState extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoadedState extends CategoriesState {
  final List<Category> categories;

  CategoriesLoadedState(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoryLoadedState extends CategoriesState {
  final Category category;

  CategoryLoadedState(this.category);

  @override
  List<Object> get props => [category];
}

class ErrorLoadingCategoriesState extends CategoriesState {
  final String message;

  ErrorLoadingCategoriesState(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorLoadingCategoryState extends CategoriesState {
  final String message;

  ErrorLoadingCategoryState(this.message);

  @override
  List<Object> get props => [message];
}
