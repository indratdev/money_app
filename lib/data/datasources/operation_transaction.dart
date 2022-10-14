import 'package:money_app/domain/entities/transaction.dart';

class OperationTransaction extends Transaction {
  OperationTransaction(
      {required super.idCategory,
      required super.title,
      required super.createdTime});
}
