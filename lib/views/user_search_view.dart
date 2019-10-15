import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_users/api/models/user.dart';
import 'package:flutter_github_users/app_drawer.dart';
import 'package:flutter_github_users/viewModels/user_search_model_impl.dart';


class UserSearchView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserSearchViewState();
}

class _UserSearchViewState extends State<UserSearchView> {
  Icon _searchActionIcon = Icon(Icons.search);
  Widget _appBarTitle = Text('Git Users');
  TextEditingController _searchController = TextEditingController();
  UserSearchModelImpl _viewModel = UserSearchModelImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: NestedScrollView(
          controller: ScrollController(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                actions: <Widget>[_createSearch()],
                forceElevated: innerBoxIsScrolled,
                title: _appBarTitle,
                expandedHeight: 150.0,

                backgroundColor: Colors.yellow,
              )
            ];
          },
          body: StreamBuilder<List<User>>(
              stream: _viewModel.users,
              builder: (context, AsyncSnapshot<List<User>> snapshot) {
                if (snapshot.hasData) {
                  return buildList(snapshot);
                } else {
                  return Text('Type something to search');
                }
              })),
    );
  }

  Widget buildList(AsyncSnapshot<List<User>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        padding: EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int pos) {
          return Card(
            child: ListTile(
              title: Text(snapshot.data[pos].login),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _subscribeToViewModel();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  Widget _createSearch() {
    return IconButton(
      icon: _searchActionIcon,
      onPressed: () {
        _viewModel.inputOnSearchPressed.add(true);
      },
    );
  }

  void _subscribeToViewModel() {
    _searchController.addListener(
        () => _viewModel.inputQueryText.add(_searchController.text));
    _viewModel.isSearching.listen((isSearching) => _responseToSearchState(isSearching));
  }

  void _responseToSearchState(bool isSearching) {
    setState(() {
      if (isSearching) {
        _searchActionIcon = Icon(Icons.close);
        _appBarTitle = TextField(
          controller: _searchController,
          decoration: InputDecoration(
              hintText: 'Search...', prefixIcon: Icon(Icons.search)),
        );
      } else {
        _appBarTitle = Text('Git Users');
        _searchActionIcon = Icon(Icons.search);
        _searchController.clear();
      }
    });
  }
}
