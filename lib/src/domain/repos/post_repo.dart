
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:users/src/data/helpers/AppConfig.dart';
import 'package:users/src/domain/entities/post.dart';
import 'package:users/src/domain/entities/user.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  String _url = AppConfig().urlbase;
  BuildContext context;
  Future init(BuildContext context){
    this.context = context;

  }


  Future<List<Post>> getPostByUser(int id)async{
    try{  
      String idUser = id.toString();
      Uri url = Uri.parse(_url + 'posts?userId=' + idUser);
      final res = await http.get(url);
      if (res.statusCode == 201 || res.statusCode == 200) {
      var data = json.decode(res.body);
      Post post = Post.fromJsonList(data);
      
      return post.postList;
      }else{
        return [];

      }
    }
    catch (e){
      print('error');
      return [];
    }
  }
}