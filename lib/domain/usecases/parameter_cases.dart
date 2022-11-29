import 'package:dartz/dartz.dart';
import 'package:money_app/domain/repositories/parameter_repository.dart';

import '../../data/failure.dart';

class ParameterCases {
  final ParameterRepository repository;

  ParameterCases(this.repository);
  // read themes
  Future<Either<Failure, List<Map<String, dynamic>>>> executeReadThemes() {
    return repository.getReadThemes();
  }

  // // update themes
  Future<Either<Failure, int>> executeUpdateThemes(String value) {
    return repository.getUpdateThemes(value);
  }
}
