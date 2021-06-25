import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tesapp/model/user_model.dart';
import 'package:tesapp/ui/home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = new TextEditingController();
    TextEditingController password = new TextEditingController();
    String token;
    String response = "";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: Text("Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(30),
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(15),
                      child: Text("Silahkan Login dengan email & password")),
                  TextField(
                    controller: email,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                  TextField(
                    controller: password,
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: RaisedButton(
                      onPressed: () {
                        User.loginUser(email.text, password.text).then((value) {
                          token = value["token"];
                          token == null
                              ? response =
                                  "Gagal Login\n" + value["error"].toString()
                              : response = "Berhasil Login\nToken: " + token;

                          AlertDialog alert = AlertDialog(
                            title: Text("Informasi"),
                            content: Text(response),
                            actions: [
                              FlatButton(
                                  child: Text("OK"),
                                  onPressed: () => Navigator.of(context).pop()),
                            ],
                          );
                          token != null
                              ? Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeScreen(),
                                  ),
                                  (route) => false,
                                )
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                          email.clear();
                          password.clear();
                          print(value);
                        });
                      },
                      color: Colors.lightBlue,
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
