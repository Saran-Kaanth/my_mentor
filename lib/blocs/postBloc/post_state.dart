part of 'post_bloc.dart';

abstract class PostState {}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {}

class PostErrorState extends PostState {}
