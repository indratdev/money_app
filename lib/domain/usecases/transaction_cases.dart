import 'package:flutter/material.dart';
import 'package:money_app/domain/repositories/transaction_repository.dart';

class TransactionCases {
  final TransactionRepository repository;

  TransactionCases(this.repository);

  // init transaction

  getInitTransaction() {
    repository.getInitTransaction();
  }
}
