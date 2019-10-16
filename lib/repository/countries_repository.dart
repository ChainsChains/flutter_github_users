import 'package:flutter_github_users/api/graphql/graphql_client.dart';
import 'package:flutter_github_users/api/models/country.dart';
import 'package:graphql/client.dart';

class CountriesRepository {
  Future<List<Country>> getCountries() {
    return getGraphQLClient().query(_queryOptions()).then(_toCountriesRepo);
  }
}

QueryOptions _queryOptions() {
  return QueryOptions(
      document: getCountries
  );
}


List<Country> _toCountriesRepo(QueryResult queryResult) {
  if (queryResult.hasErrors) {
    throw Exception();
  }

  final list = queryResult.data['continent']['countries'] as List<dynamic>;

  return list
      .map((country) => Country.fromJson(country))
      .toList(growable: false);
}


const String getCountries = r'''
# Write your query or mutation here
query {
  continent(code: "EU") {
      name
    		code
    		countries {
         name
      }
  }
}
''';