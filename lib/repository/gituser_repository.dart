import 'dart:async';

import 'package:flutter_github_users/api/models/user.dart';
import 'package:flutter_github_users/api/userApiProvider.dart';

class GitUserRepository {
  final userApiProvider = UserApiProvider();

  Future<List<User>> searchUsers(String query) =>
      userApiProvider.getUsers(query);
}
