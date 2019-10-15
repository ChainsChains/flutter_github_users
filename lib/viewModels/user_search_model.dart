import 'package:flutter_github_users/api/models/user.dart';
import 'package:rxdart/rxdart.dart';

abstract class UserSearchModel {
  Sink get inputQueryText;
  Sink get inputOnSearchPressed;

  Observable<List<User>> get users;
  Observable<bool> get isSearching;

  void dispose();
}
