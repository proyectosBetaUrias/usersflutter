import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:users/src/app/pages/user/Details/user_details_controller.dart';

import '../../../../domain/entities/post.dart';
import '../../../../domain/entities/user.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;
  const UserDetailsPage({Key key, this.user}) : super(key: key);

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
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Center(
            child: Container(
                padding: EdgeInsets.only(top: 10, left: 8, right: 8), child: _cardUser(_con.user)),
          ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Posts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                  ]
                )),
          Expanded(
            child: FutureBuilder(
                future: _con.getPostByUser(_con.user.id),
                // ignore: missing_return
                builder: (context, AsyncSnapshot<List<Post>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0 || snapshot.data.isNotEmpty) {
                      return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (_, index) {
                            return _cardPost(snapshot.data[index]);
                          });
                    } else {
                      return const Center(
                          child: Center(
                        child: Text('List is empty'),
                      ));
                    }
                  } else {
                    return Center(
                      child: Column(
                        children: const [
                          Text('Cargando usuarios'),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget _cardUser(User user) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
            child: Row(
              children: [
                Text(
                  _con.user.name,
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Icon(Icons.email),
                SizedBox(
                  width: 10,
                ),
                Text(_con.user.phone,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, bottom: 20),
            child: Row(
              children: [
                const Icon(Icons.phone),
                const SizedBox(
                  width: 10,
                ),
                Text(_con.user.email,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardPost(Post post) {
    double _sizeWidth = MediaQuery.of(context).size.width;
    double _sizeHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, 'userDetails', arguments: user);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          elevation: 3.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                child: ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 15),
              //   child: Row(
              //     children: [
              //       Flexible(
              //         child: Text(post.title,
              //             style: const TextStyle(
              //               fontWeight: FontWeight.bold,
              //             )),
              //       ),
              //     ],
              //   ),
              // ),
              // Divider(height: 20,),
              // Container(
              //   margin: EdgeInsets.only(left: 10, bottom: 20),
              //   child: Row(
              //     children: [
              //       Flexible(
              //         child:
              //           Text(post.body,
              //             style: const TextStyle(
              //               fontWeight: FontWeight.bold,
              //             )),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {}); // CTRL + S
  }
}
