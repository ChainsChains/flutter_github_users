import 'package:flutter/material.dart';

import '../app_drawer.dart';

class Something2View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Something2'),
      ),
      drawer: AppDrawer(),
    );
  }
}
