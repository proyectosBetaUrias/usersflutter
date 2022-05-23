import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:users/src/data/helpers/AppConfig.dart';
import '../../../../domain/entities/post.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/repos/post_repo.dart';

class UserDetailsController {
  String _url = AppConfig().urlbase;
  BuildContext context;
  User user;
  Function refresh;
  PostRepository _postepository = PostRepository();

  Future init (BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = ModalRoute.of(context).settings.arguments;
    this.refresh();

  }

  Future<List<Post>> getPostByUser(int id) async {
    List<Post> result = await _postepository.getPostByUser(id);
    return result;
  }
}