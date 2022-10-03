import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:money_app/data/datasources/local/local_data_source.dart';
import 'package:money_app/data/models/category_model.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/domain/repositories/category_repository.dart';

import '../exception.dart';
import '../failure.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final LocalDataSource localDataSource;

  CategoryRepositoryImpl({required this.localDataSource});

  @override
  getInitCategory() {
    try {
      print("CategoryRepositoryImpl runingg");
      final result = localDataSource.getInitCategory();
    } catch (e) {
      print(e);
    }
  }

  // @override
  // Future<Either<Failure, List<Category>>> getReadCategory() async {
  //   try {
  //     final result = await localDataSource.readCategory();
  //     print("result ::: $result");
  //     return Right(result.toList());
  //   } on ServerException {
  //     return Left(const ServerFailure(''));
  //   } on SocketException {
  //     return Left(const ConnectionFailure('Failed to connect to the database'));
  //   }
  // }

  @override
  getAddCategory() async {
    try {
      print("CategoryRepositoryImpl (getAddCategory) runingg");
      final result = await localDataSource.readCategory();
      return result;
    } catch (e) {
      print(e);
    }
  }

  @override
  getDeleteCategory() {
    // TODO: implement getDeleteCategory
    throw UnimplementedError();
  }

  @override
  getUpdateCategory() {
    // TODO: implement getUpdateCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Category>>> getReadCategory() async {
    try {
      final result = await localDataSource.readCategory();
      print("result ::: $result");
      return Right(result.toList());
      ;
    } on ServerException {
      return Left(const ServerFailure(''));
    } on SocketException {
      return Left(const ConnectionFailure('Failed to connect to the database'));
    }
  }
}
