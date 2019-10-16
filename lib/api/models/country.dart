import 'package:flutter/cupertino.dart';

class Country {
  final String name;
  final String code;

  Country({@required this.name, @required this.code});

  factory Country.fromJson(Map<String, dynamic> json) => new Country(
    name: json['name'],
    code: json['code'],
  );
}
