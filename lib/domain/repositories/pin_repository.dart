import 'package:dartz/dartz.dart';
import 'package:money_app/data/failure.dart';

abstract class PinRepository {
  Future<Either<Failure, String>> encriptDecrypt(bool isEncrypt, String value);
  bool compareTwoString(String value1, String value2);
  Future<bool> isValidPasscode(String value);
}
