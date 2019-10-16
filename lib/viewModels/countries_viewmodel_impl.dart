import 'package:flutter_github_users/api/models/country.dart';
import 'package:flutter_github_users/repository/countries_repository.dart';
import 'package:flutter_github_users/viewModels/countries_viewmodel.dart';
import 'package:rxdart/rxdart.dart';

class CountriesViewModelImpl extends CountriesViewModel {
  final _repository = CountriesRepository();
  final _countriesFetcher = PublishSubject<List<Country>>();

  CountriesViewModelImpl() {
    _repository.getCountries().then((data) {
      _countriesFetcher.add(data);
    });
  }

  @override
  Observable<List<Country>> get countries => _countriesFetcher.stream;

  @override
  dispose() {
    _countriesFetcher.close();
  }
}
