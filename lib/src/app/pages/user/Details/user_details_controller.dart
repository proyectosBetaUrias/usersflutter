import 'package:flutter/material.dart';
import '../../../../domain/entities/user.dart';

class UserDetailsController {

  BuildContext context;
  User user;
  Function refresh;

  Future init (BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = ModalRoute.of(context).settings.arguments;
    this.refresh();

  }

}