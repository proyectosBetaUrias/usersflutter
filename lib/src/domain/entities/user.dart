import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  int id;
  String name;
  String email;
  String phone;
  List<User> userList = [];

  User({
    this.id = 0, 
    this.name = "", 
    this.email = "", 
    this.phone = ""
    });


factory User.fromJson(Map<String, dynamic> json) => User(
  id: json["id"] as int,
  name: json["name"] as String,
  email: json["email"] as String,
  phone: json["phone"] as String
);

User.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      User user = User.fromJson(item);
      userList.add(user);
    }
  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name": name,
    "email": email,
    "phone": phone
  };


  Map<String, dynamic> toMap() {
    return { 'id': id, 'name': name, 'email': email, 'phone': phone};
  }

}