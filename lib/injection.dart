import 'package:get_it/get_it.dart';
import 'package:money_app/data/repositories/transaction_repository_impl.dart';
import 'package:money_app/domain/repositories/transaction_repository.dart';
import 'package:money_app/domain/usecases/transaction_cases.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';

import 'data/datasources/local/local_data_source.dart';
import 'data/repositories/category_repository_impl.dart';
import 'domain/repositories/category_repository.dart';
import 'domain/usecases/category_cases.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // bloc
  getIt.registerFactory(() => CategoryBloc(getIt()));
  getIt.registerFactory(() => TransactionBloc(getIt()));

  // usecase
  getIt.registerLazySingleton(() => CategoryCases(getIt()));
  getIt.registerLazySingleton(() => TransactionCases(getIt()));

  // repository
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      localDataSource: getIt(),
    ),
  );
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      localDataSource: getIt(),
    ),
  );

  // data source
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );
}
