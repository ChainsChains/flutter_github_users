import 'package:flutter_github_users/api/models/country.dart';
import 'package:rxdart/rxdart.dart';

abstract class CountriesViewModel {
  Observable<List<Country>> get countries;
  void dispose();
}