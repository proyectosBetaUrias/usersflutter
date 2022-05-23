import 'package:flutter/material.dart';

import '../../../../domain/entities/user.dart';
import '../../../../domain/repos/user_repo.dart';

class UserListController {
  BuildContext context;
  User user;
  UserRepository _userRepository = UserRepository();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function refresh;

  Future init (BuildContext context, Function regresh) async{
    this.context = context;
    this.refresh = refresh;
    _userRepository.init(context);
  }


  Future<List<User>> getAllUsers(String searchName) async {
    List<User> result = await _userRepository.getAllUsers(searchName);
    return result;
  }
}