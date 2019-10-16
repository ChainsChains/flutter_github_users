import 'package:flutter/material.dart';
import 'package:flutter_github_users/api/models/country.dart';
import 'package:flutter_github_users/app_drawer.dart';
import 'package:flutter_github_users/viewModels/countries_viewmodel_impl.dart';

class CountriesView extends StatelessWidget {

  CountriesViewModelImpl _viewModel = CountriesViewModelImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries'),
      ),
      drawer: AppDrawer(),
      body: StreamBuilder(
        stream: _viewModel.countries,
        builder: (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else {
            return Text('Empty snapshot');
          }

        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<Country>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        padding: EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int pos) {
          return Card(
            child: ListTile(
              title: Text(snapshot.data[pos].name),
            ),
          );
        });
  }
}
