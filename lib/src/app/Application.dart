import 'package:flutter/material.dart';
import 'package:users/src/app/pages/user/Details/user_details_view.dart';
import 'package:users/src/app/pages/user/List/user_list_view.dart';


class Application extends StatefulWidget {
  Application({Key key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prueba de Ingreso',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        home: const UserListPage(),
        routes: {
          'userDetails' : (BuildContext context) => UserDetailsPage()
        },
    );
  }
}