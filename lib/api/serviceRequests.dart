import 'dart:convert';

import 'package:flutter_github_users/api/models/myResponse.dart';
import 'package:http/http.dart' as http;

import 'models/user.dart';

class ServiceRequests {
  Future<List<User>> getUsers() async {
    final response = await http.get('https://api.github.com/search/users?&q=rembo');

    if (response.statusCode == 200) {
      return MyResponse.fromJson(jsonDecode(response.body)).items;
    } else {
      throw Exception('Failed to load Users. Code = ${response.statusCode}');
    }
  }
}