import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:money_app/data/datasources/local/local_data_source.dart';

import '../../domain/repositories/parameter_repository.dart';
import '../exception.dart';
import '../failure.dart';

class ParameterRepositoryImpl implements ParameterRepository {
  final LocalDataSource localDataSource;

  ParameterRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getReadThemes() async {
    try {
      final result = await localDataSource.readParamThemes();
      return right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the database'));
    }
  }

  @override
  Future<Either<Failure, int>> getUpdateThemes(String value) async {
    try {
      final result = await localDataSource.updateParamThemes(value);
      return right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the database'));
    }
  }

  @override
  Future<Either<Failure, bool>> getPasscodeExist() async {
    try {
      final result = await localDataSource.readPasscode();
      return right(result);
    } on ServerException {
      return left(ServerFailure('Failed to Connect Server'));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the databse"));
    }
  }
}
