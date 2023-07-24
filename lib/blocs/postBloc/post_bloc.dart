import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitialState()) {
    on<PostEvent>((event, emit) {
      print("Post Blocs");
    });

    on<PostLoadingEvent>((event, emit) {
      emit(PostLoadingState());
      print("post loading state");
      emit(PostLoadedState());
    });
  }
}
