import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
import 'package:my_mentor/data/repositories/models/post.dart';
import 'package:my_mentor/data/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository = PostRepository();
  DateFormat dateFormat = DateFormat('MMM d, yyyy');
  String? photoUrl;
  PostBloc() : super(PostInitialState()) {
    on<PostEvent>((event, emit) {
      print("Post Blocs");
    });

    on<PostLoadingEvent>((event, emit) async {
      try {
        emit(PostLoadingState());
        emit(PostLoadedState(await postRepository.retrieveMyPostDetail()));
        print("loaded success");
      } catch (e) {
        print(e.toString());
        emit(PostErrorState("Please Try Again..."));
      }
    });

    on<PostSubmittingEvent>((event, emit) async {
      try {
        emit(PostImageUploadingState());
        photoUrl = await postRepository.storePostImage(event.photoUrl);
        emit(PostImageUploadedState());
        emit(PostUploadingState());
        Post newPost = Post(
            photoUrl,
            postRepository.currentUser.displayName,
            postRepository.currentUser.uid,
            dateFormat.format(DateTime.now()).toString(),
            event.postDescription);
        await postRepository.uploadPost(newPost);
        emit(PostUploadedState());
      } catch (e) {
        print(e.toString());
        emit(PostErrorState("Error while uploading posts!"));
      }
    });
  }
}
