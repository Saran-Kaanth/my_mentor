class Post {
  final String postId;
  final String postedBy;
  final String authorId;
  final String postDate;
  final String postUrl;
  final String postDescription;
  int? likes;

  Post(this.postUrl, this.postId, this.postedBy, this.authorId, this.postDate,
      this.postDescription);

  Post.fromMap(Map<dynamic, dynamic> postData)
      : postId = postData["postId"],
        postedBy = postData["postedBy"],
        authorId = postData["authorId"],
        postDate = postData["postDate"],
        postUrl = postData["postUrl"],
        postDescription = postData["postDescription"],
        likes = postData["likes"];

  Map<String, dynamic> toMap() {
    return {
      "postId": postId,
      "postedBy": postedBy,
      "authorId": authorId,
      "postDate": postDate,
      "postUrl": postUrl,
      "postDescription": postDescription
    };
  }
}
