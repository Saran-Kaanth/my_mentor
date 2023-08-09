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
  }
}
