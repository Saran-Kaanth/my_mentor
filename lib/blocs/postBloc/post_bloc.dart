import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
import 'package:my_mentor/data/repositories/models/post.dart';
import 'package:my_mentor/data/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository = PostRepository();
  Post? newPost;
  PostBloc() : super(PostInitialState()) {
    on<PostEvent>((event, emit) {
      print("Post Blocs");
    });

    on<PostLoadingEvent>((event, emit) {
      emit(PostLoadingState());
      print("post loading state");
      emit(PostLoadedState());
    });

    on<PostSubmittingEvent>((event, emit) async {
      try {
        emit(PostImageUploadingState());
        newPost!.postUrl = await postRepository.storePostImage(event.photoUrl);
        emit(PostImageUploadedState());
        emit(PostUploadingState());
        newPost!.authorId = postRepository.currentUser.uid;
        newPost!.postedBy = postRepository.currentUser.displayName;
      } catch (e) {
        print(e.toString());
        emit(PostErrorState("Error while uploading posts!"));
      }
    });
  }
}
