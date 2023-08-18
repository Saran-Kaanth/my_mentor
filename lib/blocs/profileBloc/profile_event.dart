part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class ProfileLoadEvent extends ProfileEvent {
  bool myProfile;
  UserProfileDetailsModel? userProfileDetailsModel;
  ProfileLoadEvent({this.myProfile = true,this.userProfileDetailsModel});
}

class ProfileEditEvent extends ProfileEvent {}

class ProfileUpdateEvent extends ProfileEvent {
  UserProfileDetailsModel userProfileDetailsModel;
  bool initial;
  ProfileUpdateEvent(this.userProfileDetailsModel, this.initial);
}

class ProfileWidgetChangeEvent extends ProfileEvent {
  int index;
  ProfileWidgetChangeEvent(this.index);
}

class FetchAuthorImgNameEvent extends ProfileEvent {
  String authorId;
  FetchAuthorImgNameEvent(this.authorId);
}
