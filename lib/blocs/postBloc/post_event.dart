part of 'post_bloc.dart';

abstract class PostEvent {}

class PostLoadingEvent extends PostEvent {}

class PostLoadedEvent extends PostEvent {}

class PostSubmittingEvent extends PostEvent {
  String photoUrl;
  String postDescription;

  PostSubmittingEvent(this.photoUrl, this.postDescription);
}
