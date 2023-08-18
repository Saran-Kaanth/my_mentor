// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mentor/data/models/user.dart';
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
        if (event.myProfile) {
          UserProfileDetailsModel userProfileDetailsModel =
              await ProfileRepository().retrieveUserProfile();
          emit(ProfileLoadedState(
              userProfileDetailsModel: userProfileDetailsModel));
        } else {
          emit(ProfileLoadedState(
              userProfileDetailsModel: event.userProfileDetailsModel));
        }
      } catch (e) {
        emit(ProfileErrorState("Unable to fetch data"));
      }
    });

    on<ProfileUpdateEvent>((event, emit) async {
      try {
        emit(ProfileUpdatingState());
        await ProfileRepository()
            .updateUserProfile(event.userProfileDetailsModel);
        if (event.initial) {
          emit(SetupInitialProfileState());
        } else {
          emit(ProfileUpdatedState());
        }
      } catch (e) {
        emit(ProfileErrorState("Please Try Again"));
      }
    });
  }
}
