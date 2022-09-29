import 'package:get_it/get_it.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';

import 'data/datasources/local/local_data_source.dart';
import 'data/repositories/category_repository_impl.dart';
import 'domain/repositories/category_repository.dart';
import 'domain/usecases/category_cases.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // bloc
  getIt.registerFactory(() => CategoryBloc(getIt()));

  // usecase
  getIt.registerLazySingleton(() => CategoryCases(getIt()));

  // repository
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      localDataSource: getIt(),
    ),
  );

  // data source
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );
}
