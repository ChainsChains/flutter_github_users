import 'dart:async';

import 'package:flutter_github_users/api/models/user.dart';
import 'package:flutter_github_users/repository/gituser_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'user_search_viewmodel.dart';

class UserSearchViewModelImpl implements UserSearchViewModel {
  final _repository = GitUserRepository();
  final _usersFetcher = PublishSubject<List<User>>();
  final _isSearchingFetcher = PublishSubject<bool>();

  var _queryTextController = StreamController<String>.broadcast();
  var _searchButtonController = StreamController.broadcast();

  bool _isSearching = false;

  UserSearchViewModelImpl() {
    _queryTextController.stream.listen((query) {
      _repository.searchUsers(query).then((users) {
        _usersFetcher.sink.add(users);
      });
    });
    _searchButtonController.stream.listen((_) {
      _isSearching = !_isSearching;
      if (!_isSearching) clearUserList();
      _isSearchingFetcher.add(_isSearching);
    });
  }

  void clearUserList() {
    _usersFetcher.add([]);
  }

  @override
  Sink get inputQueryText => _queryTextController;

  @override
  Sink get inputOnSearchPressed => _searchButtonController;

  @override
  Observable<List<User>> get users => _usersFetcher.stream;

  @override
  Observable<bool> get isSearching => _isSearchingFetcher.stream;

  @override
  dispose() {
    _usersFetcher.close();
    _queryTextController.close();
    _searchButtonController.close();
    _isSearchingFetcher.close();
  }
}
