import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_users/api/models/user.dart';
import 'package:flutter_github_users/api/serviceRequests.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H','A', 'B', 'C', 'D', 'E', 'F', 'G', 'H','A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
  List<User> users = <User>[];
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: ScrollController(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: false,
              snap: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              title: Text('MyDemoApp'),
              backgroundColor: Colors.yellow,
            )
          ];
        },
        body: ListView.builder(
            itemCount: users.length,
            padding: EdgeInsets.all(16.0),
            itemBuilder: (BuildContext context, int pos) {
              return Card(
                child: ListTile(

                  title: Text(users[pos].login),
                ),
              );
            }),
      ),
    );
  }

  @override
  void initState() {
    _loadUsers();
  }
  
  _loadUsers() {
    ServiceRequests().getUsers().then((list) {
      setState(() {
        users = list;
      });
    });
  }
}
