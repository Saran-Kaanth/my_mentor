part of 'search_bloc.dart';

class SearchEvent {}

class InitialRecomEvent extends SearchEvent {}

class SearchUserEvent extends SearchEvent {
  String searchText;
  SearchUserEvent(this.searchText);
}
