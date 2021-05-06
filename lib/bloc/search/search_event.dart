part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class Searching extends SearchEvent {
  final String keyword;

  Searching(this.keyword);

  @override
  List<Object> get props => [keyword];
}
