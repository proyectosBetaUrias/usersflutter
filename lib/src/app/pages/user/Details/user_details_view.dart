import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:users/src/app/pages/user/Details/user_details_controller.dart';

import '../../../../domain/entities/user.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;
  const UserDetailsPage({ Key key, this.user }) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
UserDetailsController _con = new UserDetailsController();
User user = User();
@override
void initState() {
  super.initState();
  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    _con.init(context, refresh);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del usuario')),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Container(
                            margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                      child: Row(
                        children: [
                          Text(_con.user.name, style: const TextStyle(fontSize: 18, color: Colors.green),),
                        ],
                      ),
                    ),
                    Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          const Icon(Icons.email),
                          SizedBox(width: 10,),
                          Text(_con.user.phone, style: const TextStyle(fontWeight: FontWeight.bold,)),
                        ],
                      ),
                    ),
                    Container(
                            margin: EdgeInsets.only(left: 10, bottom: 20),
                      child: Row(
                        children: [
                          const Icon(Icons.phone),
                          const SizedBox(width: 10,),
                          Text(_con.user.email, style: const TextStyle(fontWeight: FontWeight.bold,)),
                        ],
                      ),
                    ),

                    Container(
                            margin: EdgeInsets.only(right: 10, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text("VER PUBLICACIONES", style: TextStyle(fontSize: 18, color: Colors.green),)
                        ]
                      )
                    )

                  ],
                ),
                ),
            ),
          ),
        ],
      ),
      
    );
  }

  void refresh() {
    setState(() {}); // CTRL + S
  }
}