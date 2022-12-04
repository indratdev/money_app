import 'package:dartz/dartz.dart';

import '../../data/failure.dart';

abstract class ParameterRepository {
  Future<Either<Failure, List<Map<String, dynamic>>>> getReadThemes();
  Future<Either<Failure, int>> getUpdateThemes(String value);
  Future<Either<Failure, bool>> getPasscodeExist();
  Either<Failure, Map<String, dynamic>> changePasscode(int value);
  Either<Failure, Map<String, dynamic>> removeDigitPasscode();
  Future<Either<Failure, bool>> savingPasscode(String value);
}
