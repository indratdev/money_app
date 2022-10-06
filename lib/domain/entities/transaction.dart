import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final int? id;
  final int isOutcome, idCategory, idWallet, isModifield;
  final String title, description;
  final double amount;
  final String createdTime, modifieldTrxTime;

  Transaction({
    this.id,
    required this.isOutcome,
    required this.idCategory,
    required this.title,
    this.description = "",
    this.amount = 0,
    this.idWallet = 0,
    required this.createdTime,
    this.isModifield = 0,
    this.modifieldTrxTime = "",
  });

  @override
  List<Object?> get props => [
        id,
        isOutcome,
        idCategory,
        title,
        description,
        amount,
        idWallet,
        createdTime,
        isModifield,
        modifieldTrxTime,
      ];
}
