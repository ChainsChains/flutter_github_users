import 'package:flutter/cupertino.dart';
import 'package:flutter_github_users/api/models/country.dart';

class Continent {
  final String name;
  final List<Country> countries;

  Continent({@required this.name, @required this.countries});
}
