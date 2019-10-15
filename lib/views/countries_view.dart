import 'package:flutter/material.dart';
import 'package:flutter_github_users/app_drawer.dart';

class CountriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries'),
      ),
      drawer: AppDrawer(),
    );
  }
}
