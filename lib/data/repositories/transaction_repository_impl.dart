import 'package:money_app/domain/repositories/transaction_repository.dart';

import '../datasources/local/local_data_source.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final LocalDataSource localDataSource;

  TransactionRepositoryImpl({required this.localDataSource});

  @override
  getInitTransaction() {
    // TODO: implement getInitTransaction
    throw UnimplementedError();
  }
}
