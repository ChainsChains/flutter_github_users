import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_users/api/models/user.dart';
import 'package:flutter_github_users/api/serviceRequests.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> _users = <User>[];
  Icon _searchActionIcon = Icon(Icons.search);
  Widget _appBarTitle = Text('Git Users');
  TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;

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
              actions: <Widget>[_createSearch()],
              forceElevated: innerBoxIsScrolled,
              title: _appBarTitle,
              backgroundColor: Colors.yellow,
            )
          ];
        },
        body: ListView.builder(
            itemCount: _users.length,
            padding: EdgeInsets.all(16.0),
            itemBuilder: (BuildContext context, int pos) {
              return Card(
                child: ListTile(
                  title: Text(_users[pos].login),
                ),
              );
            }),
      ),
    );
  }

  @override
  void initState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.length > 0) {
        _loadUsers(_searchQuery.text);
      }
    });
  }

  @override
  void dispose() {
    _searchQuery.dispose();
  }

  Widget _createSearch() {
    return IconButton(
      icon: _searchActionIcon,
      onPressed: () {
        setState(() {
          if (_isSearching) {
            _appBarTitle = Text('Git Users');
            _searchActionIcon = Icon(Icons.search);
            _searchQuery.clear();
          } else {
            _searchActionIcon = Icon(Icons.close);
            _appBarTitle = TextField(
              controller: _searchQuery,
              decoration: InputDecoration(
                  hintText: 'Search...', prefixIcon: Icon(Icons.search)),
            );
          }
          _isSearching = !_isSearching;
        });
      },
    );
  }

  _loadUsers(String query) {
    ServiceRequests().getUsers(query).then((list) {
      setState(() {
        _users = list;
      });
    });
  }
}
