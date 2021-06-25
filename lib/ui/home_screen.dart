import 'package:flutter/material.dart';
import 'package:tesapp/model/user_model.dart';
import 'package:tesapp/ui/detail_screen.dart';
import 'package:tesapp/ui/tambah_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Employee App"),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: User.getUsers("2"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              iduser: snapshot.data[index]['id'].toString(),
                            ),
                          ),
                          (route) => false,
                        );
                      },
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(snapshot.data[index]['avatar']),
                          ),
                          title: Text(snapshot.data[index]['first_name'] +
                              " " +
                              snapshot.data[index]['last_name']),
                          subtitle: Text(snapshot.data[index]['email']),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TambahScreen(),
            ),
            (route) => false,
          );
        },
      ),
    ));
  }
}
