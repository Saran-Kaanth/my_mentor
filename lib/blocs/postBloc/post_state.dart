part of 'post_bloc.dart';

abstract class PostState {}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostImageUploadingState extends PostState {}

class PostImageUploadedState extends PostState {}

class PostUploadingState extends PostState {}

class PostUploadedState extends PostState {}

class PostLoadedState extends PostState {}

class PostErrorState extends PostState {
  String errorMessage;
  PostErrorState(this.errorMessage);
}
