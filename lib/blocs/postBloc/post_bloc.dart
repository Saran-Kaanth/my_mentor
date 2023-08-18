import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:my_mentor/blocs/authBloc/auth_bloc.dart';
import 'package:my_mentor/data/models/post.dart';
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
        // print(event.userId);
        var postList =
            await postRepository.retrieveMyPostDetail(userId: event.userId);
        emit(PostLoadedState(myPostsList: postList));
        print(postList);
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
        // Post newPost = Post(postUrl: photoUrl!, postedBy: postRepository.currentUser.displayName!, authorId: postRepository.currentUser.uid,
        // postDate: dateFormat.format(DateTime.now()).toString(), postDescription: event.postDescription);
        Post newPost = Post(
            postRepository.currentUser.displayName,
            photoUrl,
            postRepository.currentUser.uid,
            dateFormat.format(DateTime.now()).toString(),
            event.postDescription,
            0);
        await postRepository.uploadPost(newPost);
        emit(PostUploadedState());
      } catch (e) {
        print(e.toString());
        emit(PostErrorState("Error while uploading posts!"));
      }
    });

    on<AllPostRetrieveEvent>((event, emit) async {
      try {
        emit(AllPostsRetrievingState());
        var allPostsList = await postRepository.retrieveAllPosts();
        emit(AllPostsRetreivedState(allPostsList));
      } catch (e) {
        PostErrorState("Try Again Later");
      }

      // print("post data loaded");
    });
  }
}
