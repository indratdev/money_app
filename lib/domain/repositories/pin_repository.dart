import 'package:dartz/dartz.dart';
import 'package:money_app/data/failure.dart';

abstract class PinRepository {
//   Future<Either<Failure, List<Map<String, dynamic>>>> getReadThemes();
//   Future<Either<Failure, int>> getUpdateThemes(String value);
//   Future<Either<Failure, bool>> getPasscodeExist();
//   Either<Failure, Map<String, dynamic>> changePasscode(int value);
//   Either<Failure, Map<String, dynamic>> removeDigitPasscode();
//   Future<Either<Failure, bool>> savingPasscode(String value);
//   // Future<Either<Failure, bool>>
  // removePasscodeDevice(String value);
  Future<Either<Failure, String>> encriptDecrypt(bool isEncrypt, String value);
  bool compareTwoString(String value1, String value2);
}
