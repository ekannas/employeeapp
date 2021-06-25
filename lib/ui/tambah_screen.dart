import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tesapp/model/user_model.dart';
import 'package:tesapp/ui/home_screen.dart';

class TambahScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = new TextEditingController();
    TextEditingController password = new TextEditingController();
    String token;
    String response = "";
    return new WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.lightBlue,
            title: Text("Register"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
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
                            User.registerUser(email.text, password.text)
                                .then((value) {
                              token = value["token"];
                              // response = value["token"];
                              if (token == null) {
                                response = "Gagal Register\n" +
                                    value["error"].toString();
                              } else {
                                response = "Berhasil Register\nToken: " + token;
                              }
                              email.clear();
                              password.clear();
                              AlertDialog alert = AlertDialog(
                                title: Text("Informasi"),
                                content: Text(response),
                                actions: [
                                  FlatButton(
                                      child: Text("OK"),
                                      onPressed: () =>
                                          Navigator.of(context).pop()),
                                ],
                              );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                              print(value);
                            });
                          },
                          color: Colors.lightBlue,
                          child: Text(
                            "Register",
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
        ),
        onWillPop: () async {
          return false;
        });
  }
}
