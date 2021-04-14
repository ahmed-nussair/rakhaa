part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class LoadingCategories extends CategoriesEvent {
  @override
  List<Object> get props => [];
}

class LoadCategory extends CategoriesEvent {
  final int categoryId;

  LoadCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
