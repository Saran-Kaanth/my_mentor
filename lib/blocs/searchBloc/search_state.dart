part of 'search_bloc.dart';

class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchRecomDataState extends SearchState {
  List<UserProfileDetailsModel>? locBasedUsersProfiles;
  SearchRecomDataState(this.locBasedUsersProfiles);
}

class SearchErrorState extends SearchState {
  String? errorMessage;
  SearchErrorState(this.errorMessage);
}
