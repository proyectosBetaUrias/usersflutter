import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:users/src/app/pages/user/Details/user_details_view.dart';
import 'package:users/src/app/pages/user/List/user_list_controller.dart';

import '../../../../domain/entities/user.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({ Key key }) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
UserListController _con = new UserListController();
  TextEditingController searchController = TextEditingController();
String searchString = "";

@override
  void setState(VoidCallback fn) {
    super.setState(fn);
    refresh();
  }
@override
void initState() {
  super.initState();
  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    _con.init(context, refresh);
  refresh();
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            key: _con.key,
      appBar: AppBar(
        title: const Text('Prueba de Ingreso')
        ),
        body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  searchString = value;
                  setState(() {
                    
                  });
                },
                controller: searchController,
                decoration: const InputDecoration(
                    labelText: "Buscar",
                    hintText: "Buscar",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: FutureBuilder(
          future: _con.getAllUsers(searchString),
          // ignore: missing_return
          builder: (context, AsyncSnapshot<List<User>> snapshot) {
            if(snapshot.hasData){
              if(snapshot.data.length > 0 || snapshot.data.isNotEmpty){
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (_, index){
                    return _cardUser(snapshot.data[index]);
                  }
                );
              }else{
                return const Center(child: Center(child: Text('List is empty'),));
              }
            }else {
              return Center(
                child: Column(
                  children: const [
                    Text('Cargando usuarios'),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          }
        ),
        ),
          ]
        ))
    );
    
  }
  Widget _cardUser(User user) {
    double _sizeWidth = MediaQuery.of(context).size.width;
    double _sizeHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
    Navigator.pushNamed(context, 'userDetails', arguments: user);

      },
      child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                child: Row(
                  children: [
                    Text(user.name, style: const TextStyle(fontSize: 18, color: Colors.green),),
                  ],
                ),
              ),
              Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    const Icon(Icons.email),
                    SizedBox(width: 10,),
                    Text(user.phone, style: const TextStyle(fontWeight: FontWeight.bold,)),
                  ],
                ),
              ),
              Container(
                      margin: EdgeInsets.only(left: 10, bottom: 20),
                child: Row(
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(width: 10,),
                    Text(user.email, style: const TextStyle(fontWeight: FontWeight.bold,)),
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
    );
  }

  void refresh() {
    setState(() {});
  }
}