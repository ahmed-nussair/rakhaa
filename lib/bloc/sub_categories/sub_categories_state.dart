part of 'sub_categories_bloc.dart';

abstract class SubCategoriesState extends Equatable {
  const SubCategoriesState();
}

class SubCategoriesInitial extends SubCategoriesState {
  @override
  List<Object> get props => [];
}

class LoadingSubCategoriesState extends SubCategoriesState {
  @override
  List<Object> get props => [];
}

class SubCategoriesLoadedState extends SubCategoriesState {
  final List<SubCategory> subCategories;

  SubCategoriesLoadedState(this.subCategories);

  @override
  List<Object> get props => [subCategories];
}

class ErrorLoadingSubCategoriesState extends SubCategoriesState {
  final String message;

  ErrorLoadingSubCategoriesState(this.message);

  @override
  List<Object> get props => [message];
}
