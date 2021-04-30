part of 'sub_categories_bloc.dart';

abstract class SubCategoriesEvent extends Equatable {
  const SubCategoriesEvent();
}

class LoadingSubCategories extends SubCategoriesEvent {
  final int categoryId;

  LoadingSubCategories(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
