import 'package:graphql/client.dart';

final HttpLink _httpLink = HttpLink(
  uri: 'https://countries.trevorblades.com/',
);

//const MY_ACCESS_TOKEN = 'myaccesstoken';
//final AuthLink _authLink = AuthLink(
//  getToken: () async => 'Bearer $MY_ACCESS_TOKEN',
//);
//final _link = _authLink.concat(_httpLink);

GraphQLClient _client;

GraphQLClient getGraphQLClient() {
  _client ??= GraphQLClient(
    cache: InMemoryCache(),
    link: _httpLink,
  );

  return _client;
}
