import 'package:users/src/domain/entities/user.dart';

class Post {
  int userId;
  int id;
  String title;
  String body;
  List<Post> postList = [];

  Post({
    this.userId,
    this.id,
    this.title,
    this.body
  });

factory Post.fromJson(Map<String, dynamic> json) => Post(
  userId: json["userId"] as int,
  id: json["id"] as int,
  title: json["title"] as String,
  body: json["body"] as String
);


Post.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      Post post = Post.fromJson(item);
      postList.add(post);
    }
  }
}