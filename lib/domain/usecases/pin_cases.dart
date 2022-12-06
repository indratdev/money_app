import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../repositories/pin_repository.dart';

class PinCases {
  final PinRepository repository;

  PinCases(this.repository);

  Future<Either<Failure, String>> executeEncryptDecrypt(
      bool isEncrypt, String value) {
    return repository.encriptDecrypt(isEncrypt, value);
  }

  bool executeCompareTwoString(String value1, String value2) {
    return repository.compareTwoString(value1, value2);
  }
}
