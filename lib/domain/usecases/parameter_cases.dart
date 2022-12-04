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

  // update themes
  Future<Either<Failure, int>> executeUpdateThemes(String value) {
    return repository.getUpdateThemes(value);
  }

  // check passcode exist
  Future<Either<Failure, bool>> executeCheckPasscodeExist() {
    return repository.getPasscodeExist();
  }

  // change passcode
  Either<Failure, Map<String, dynamic>> executeChangePasscode(int value) {
    return repository.changePasscode(value);
  }

  // remove digit passcode
  Either<Failure, Map<String, dynamic>> executeRemoveDigitPasscode() {
    return repository.removeDigitPasscode();
  }

  // saving passcode
  Future<Either<Failure, bool>> executeSavingPasscode(String value) {
    return repository.savingPasscode(value);
  }
}
