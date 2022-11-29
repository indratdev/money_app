import 'package:dartz/dartz.dart';

import '../../data/failure.dart';

abstract class ParameterRepository {
  Future<Either<Failure, List<Map<String, dynamic>>>> getReadThemes();
  Future<Either<Failure, int>> getUpdateThemes(String value);
}
