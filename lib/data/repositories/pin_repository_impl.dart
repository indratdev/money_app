import 'dart:io';

import 'package:money_app/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:money_app/domain/repositories/pin_repository.dart';

import '../datasources/local/local_data_source.dart';
import '../exception.dart';
import '../pin_manager.dart';

class PinRepositoryImpl implements PinRepository {
  final LocalDataSource localDataSource;
  final pm = PinManager();
  // final PinManager pinManager;

  PinRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> encriptDecrypt(
      bool isEncrypt, String value) async {
    try {
      final result = pm.encryptDecryptPasscode(true, value);
      return right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the database'));
    }
  }

  @override
  bool compareTwoString(String value1, String value2) {
    try {
      return pm.compareTwoString(value1, value2);
    } catch (e) {
      print("error : $e");
      return false;
    }
  }

  // @override
  // bool compareTwoString(String value1, String value2) {
  //   bool status = false;
  //   try {
  //     return pm.compareTwoString(value1, value2);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
