import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:users/src/data/DB_Manager.dart';
import 'package:users/src/data/helpers/AppConfig.dart';
import '../entities/user.dart';

class UserRepository {
  String _url = AppConfig().urlbase;
  BuildContext context;
  Future init(BuildContext context){
    this.context = context;

  }
  Future<List<User>> getAllUsers(String searchName)async{
    try{  
      Uri url = Uri.http(_url, 'users');
      final res = await http.get(url);
List<User> users;
      if (res.statusCode == 201 || res.statusCode == 200) {
      var data = json.decode(res.body);
      User user = User.fromJsonList(data);
      await DB_Manager.saveUsers(user.userList);
      users = await DB_Manager.getUsers(searchName);
      
      return users;
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