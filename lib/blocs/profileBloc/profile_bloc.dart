// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mentor/data/repositories/models/user.dart';
import 'package:my_mentor/data/repositories/profile_repository.dart';
// import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileEvent>((event, emit) {
      print("hello profile");
    });

    on<ProfileLoadEvent>((event, emit) async {
      try {
        emit(ProfileLoadingState());
        print("profileLoading success");
        UserProfileDetailsModel userProfileDetailsModel =
            await ProfileRepository().retrieveUserProfile();
        emit(ProfileLoadedState(
            userProfileDetailsModel: userProfileDetailsModel));
        print("ProfileLoaded success");
      } catch (e) {
        throw Exception(e.toString());
      }
    });

    on<ProfileWidgetChangeEvent>((event, emit) {
      emit(ProfileWidgedChangedState(event.index));
    });
  }
}
