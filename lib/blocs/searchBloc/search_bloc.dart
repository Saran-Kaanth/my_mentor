// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mentor/data/models/user.dart';
import 'package:my_mentor/data/repositories/profile_repository.dart';
// import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<InitialRecomEvent>((event, emit) async {
      UserProfileDetailsModel currentUserData;
      emit(SearchLoadingState());
      try {
        currentUserData = await ProfileRepository().retrieveUserProfile();
        var locBasedUserData = await ProfileRepository()
            .retrieveLocBasedUsers(currentUserData.city!);
        emit(SearchRecomDataState(locBasedUserData));
      } catch (e) {
        emit(SearchErrorState("Try Searching for better results..."));
      }
    });

    on<SearchUserEvent>((event, emit) async {
      try {
        emit(SearchLoadingState());
        // print(event.searchText);
        var matchedUsersData =
            await ProfileRepository().retrieveMatchedUsers(event.searchText);
        // print("displayname" + matchedUsersData![0].displayName.toString());
        // for (var element in matchedUsersData!) {
        //   if (element.displayName == event.searchText) {
        //     print(element.displayName.toString() + " the display name");
        //   }
        // }
        emit(SearchResultState(matchedUsersData));
        // print("searching");
      } catch (e) {
        emit(SearchErrorState("Sorry! Not able to fetch users right now...😞"));
      }
    });
  }
}
