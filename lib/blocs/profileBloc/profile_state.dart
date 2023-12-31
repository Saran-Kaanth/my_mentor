part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  UserProfileDetailsModel? userProfileDetailsModel;
  ProfileLoadedState({this.userProfileDetailsModel});
}

class ProfileUpdatingState extends ProfileState{}

class ProfileUpdatedState extends ProfileState {}

class SetupInitialProfileState extends ProfileState{}

class ProfileErrorState extends ProfileState {
  String errorMessage;
  ProfileErrorState(this.errorMessage);
}


