part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class ProfileLoadEvent extends ProfileEvent {}

class ProfileEditEvent extends ProfileEvent {}

class ProfileUpdateEvent extends ProfileEvent {}

class ProfileWidgetChangeEvent extends ProfileEvent {
  int index;
  ProfileWidgetChangeEvent(this.index);
}
