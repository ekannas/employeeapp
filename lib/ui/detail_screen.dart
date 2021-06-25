import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tesapp/model/user_model.dart';

import 'home_screen.dart';

class DetailScreen extends StatefulWidget {
  final String iduser;
  const DetailScreen({Key key, @required this.iduser}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  User user;
  String email = "";
  String fistName = "";
  String lastName = "";
  String avatar = "https://via.placeholder.com/140x100";

  @override
  void initState() {
    super.initState();
    User.getDetail(widget.iduser).then((value) {
      setState(() {
        user = value;
        avatar = user.avatar;
        email = user.email;
        fistName = user.firstName;
        lastName = user.lastName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(fistName + " " + lastName),
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
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Card(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 60.0,
                            child: ClipOval(
                              child: Image.network(
                                avatar,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 20, bottom: 20, right: 10, left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[Text(fistName + " " + lastName)],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 20, bottom: 20, right: 10, left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[Text(email)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}
