import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  User({this.id, this.email, this.firstName, this.lastName, this.avatar});

  static Future<List<dynamic>> getUsers(String page) async {
    String apiUrl = "https://reqres.in/api/users?page=" + page;
    var result = await http.get(apiUrl);
    return json.decode(result.body)['data'];
  }

  factory User.createUser(Map<String, dynamic> object) {
    return User(
        id: object["id"].toString(),
        email: object["email"],
        firstName: object["first_name"],
        lastName: object["last_name"],
        avatar: object["avatar"]);
  }
  static Future<User> getDetail(String id) async {
    String apiUrl = "https://reqres.in/api/users/" + id;
    var apiResult = await http.get(apiUrl);
    var jsonObject = json.decode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>)['data'];

    return User.createUser(userData);
  }

  static Future registerUser(String email, String password) async {
    var response = await http.post("https://reqres.in/api/register",
        body: {'email': email, 'password': password});
    var message = jsonDecode(response.body);
    return message;
  }

  static Future loginUser(String email, String password) async {
    var response = await http.post("https://reqres.in/api/login",
        body: {'email': email, 'password': password});
    var message = jsonDecode(response.body);
    return message;
  }
}
