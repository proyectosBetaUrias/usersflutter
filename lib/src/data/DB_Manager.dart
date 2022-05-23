import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../domain/entities/user.dart';

class DB_Manager {
  static Future<Database> _openDB()async{
    try{
    return openDatabase(join(await getDatabasesPath(), 'users.db'),
    onCreate: (db, version){
      print('database');
      return db.execute(
        "CREATE TABLE users (id INTEGER PRIMARYKEY, name TEXT, email TEXT, phone TEXT)"
      );
    }, version: 1);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future<void> saveUsers(List<User> lstUser) async{
    Database database = await _openDB();
    int count = Sqflite
         .firstIntValue(await database.rawQuery('SELECT COUNT(*) FROM users'));
         if(count == 0){

      database.execute(
        "DROP TABLE users"
      );
      database.execute(
        "CREATE TABLE users (id INTEGER PRIMARYKEY, name TEXT, email TEXT, phone TEXT)"
      );
    for (var user in lstUser) {
      database.insert('users', user.toMap());

    }
         }

  }

  static Future<List<User>> getUsers(String searchname) async{
    Database database = await _openDB();

     List<Map<String, dynamic>> usermap;
    if(searchname == ""){
      usermap = await database.query("users");
    } 
    else{
      usermap = await database.query("users",
  where: "name LIKE ?",
  whereArgs: ['%$searchname%']
  );

    }

if(usermap.length == 0){
  return [];
}else{
    return List.generate(usermap.length, (index) => User(
      id: usermap[index]['id'],
      name: usermap[index]['name'],
      email: usermap[index]['email'],
      phone: usermap[index]['phone']
      ));
  }
  }
}