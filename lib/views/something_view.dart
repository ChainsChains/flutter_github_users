import 'package:flutter/material.dart';

import '../app_drawer.dart';

class SomethingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Something'),
      ),
      drawer: AppDrawer(),
    );
  }
}
