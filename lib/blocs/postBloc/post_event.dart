part of 'post_bloc.dart';

abstract class PostEvent {}

class PostLoadingEvent extends PostEvent {}

class PostLoadedEvent extends PostEvent {}

