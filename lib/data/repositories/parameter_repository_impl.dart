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
      return Left(const ServerFailure(''));
    } on SocketException {
      return Left(const ConnectionFailure('Failed to connect to the database'));
    }
  }

  @override
  Future<Either<Failure, int>> getUpdateThemes(String value) async {
    try {
      final result = await localDataSource.updateParamThemes(value);
      // updateTransaction(
      //     idTransaction, valueTransaction);

      return right(result);
    } on ServerException {
      return Left(const ServerFailure(''));
    } on SocketException {
      return Left(const ConnectionFailure('Failed to connect to the database'));
    }
  }

  // @override
  // Future<Either<Failure, String>> getUpdateThemes(String value) {
  //   try {
  //     // final result = await localDataSource.upda
  //   } catch (e) {

  //   }
  // }

  // @override
  // getInitCategory() {
  //   try {
  //     print("CategoryRepositoryImpl runingg");
  //     final result = localDataSource.getInitCategory();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // // @override
  // // Future<Either<Failure, List<Category>>> getReadCategory() async {
  // //   try {
  // //     final result = await localDataSource.readCategory();
  // //     print("result ::: $result");
  // //     return Right(result.toList());
  // //   } on ServerException {
  // //     return Left(const ServerFailure(''));
  // //   } on SocketException {
  // //     return Left(const ConnectionFailure('Failed to connect to the database'));
  // //   }
  // // }

  // @override
  // getAddCategory() async {
  //   try {
  //     print("CategoryRepositoryImpl (getAddCategory) runingg");
  //     final result = await localDataSource.readCategory(1);
  //     return result;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // @override
  // Future<Either<Failure, List<Category>>> getReadCategory() async {
  //   try {
  //     final result = await localDataSource.readCategory(0);
  //     print("result ::: $result");
  //     return Right(result.toList());
  //   } on ServerException {
  //     return Left(const ServerFailure(''));
  //   } on SocketException {
  //     return Left(const ConnectionFailure('Failed to connect to the database'));
  //   }
  // }

  // @override
  // Future<Either<Failure, List<Category>>> getReadIconCategoryDefault(
  //     isdefault) async {
  //   try {
  //     final result = await localDataSource.readCategory(isdefault);
  //     return Right(result.toList());
  //   } on ServerException {
  //     return Left(const ServerFailure(''));
  //   } on SocketException {
  //     return Left(const ConnectionFailure('Failed to connect to the database'));
  //   }
  // }

  // @override
  // Future<Either<Failure, int>> getCreateCategory(Category value) async {
  //   try {
  //     final result = await localDataSource.createCategory(value);
  //     print("jalannn getCreateCategory: ${Right(result)}");
  //     return Right(result);
  //   } on ServerException {
  //     return Left(const ServerFailure(''));
  //   } on SocketException {
  //     return Left(const ConnectionFailure('Failed to connect to the database'));
  //   }
  // }

  // @override
  // Future<Either<Failure, Category>> getReadCategoryById(int idCategory) async {
  //   try {
  //     final result = await localDataSource.readCategoryById(idCategory);
  //     print("result getReadCategoryById ::: $result");
  //     return Right(result);
  //   } on ServerException {
  //     return Left(const ServerFailure(''));
  //   } on SocketException {
  //     return Left(const ConnectionFailure('Failed to connect to the database'));
  //   }
  // }

  // @override
  // Future<Either<Failure, int>> getUpdateCategory(
  //     int idCategory, Category valueCategory) async {
  //   try {
  //     final result =
  //         await localDataSource.updateCategory(idCategory, valueCategory);
  //     return right(result);
  //   } on ServerException {
  //     return Left(const ServerFailure(''));
  //   } on SocketException {
  //     return Left(const ConnectionFailure('Failed to connect to the database'));
  //   }
  // }

  // @override
  // Future<Either<Failure, void>> getDeleteCategory(int idCategory) async {
  //   try {
  //     final result = await localDataSource.deleteCategory(idCategory);
  //     return right(result);
  //   } on ServerException {
  //     return Left(const ServerFailure(''));
  //   } on SocketException {
  //     return Left(const ConnectionFailure('Failed to connect to the database'));
  //   }
  // }
}
