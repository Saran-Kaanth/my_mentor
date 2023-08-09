class Post {
  String? postedBy;
  String? postUrl;
   String? authorId;
   String? postDate;
   String? postDescription;
   int? likes;

  Post(this.postedBy, this.postUrl, this.authorId, this.postDate,
      this.postDescription, this.likes);

  Post.fromMap(Map<dynamic, dynamic> postData)
      : postedBy = postData["postedBy"],
        postUrl = postData["postUrl"],
        authorId = postData["authorId"],
        postDate = postData["postDate"],
        postDescription = postData["postDescription"],
        likes = postData["likes"];

  Map<String, dynamic> toMap() {
    return {
      "postedBy": postedBy,
      "postUrl": postUrl,
      "authorId": authorId,
      "postDate": postDate,
      "postDescription": postDescription,
      "likes": likes
    };
  }
}
