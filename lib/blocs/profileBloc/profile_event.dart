part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class ProfileLoadEvent extends ProfileEvent {}

class ProfileEditEvent extends ProfileEvent {}

class ProfileUpdateEvent extends ProfileEvent {
  UserProfileDetailsModel userProfileDetailsModel;
  ProfileUpdateEvent(this.userProfileDetailsModel);
}

class ProfileWidgetChangeEvent extends ProfileEvent {
  int index;
  ProfileWidgetChangeEvent(this.index);
}

class FetchAuthorImgNameEvent extends ProfileEvent {
  String authorId;
  FetchAuthorImgNameEvent(this.authorId);
}
