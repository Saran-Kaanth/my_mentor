part of 'post_bloc.dart';

abstract class PostEvent {}

class PostLoadingEvent extends PostEvent {
  String? userId;
  PostLoadingEvent({this.userId=""});
}

class PostLoadedEvent extends PostEvent {}

class PostSubmittingEvent extends PostEvent {
  String photoUrl;
  String postDescription;

  PostSubmittingEvent(this.photoUrl, this.postDescription);
}

class AllPostRetrieveEvent extends PostEvent {}
