import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  int? id;
  int isOutcome, idCategory, idWallet, isModifield;
  String title;
  String? description;
  double amount;
  String createdTime, modifieldTrxTime;
  String? categoryName, categoryIconName;

  Transaction({
    this.id,
    this.isOutcome = 0,
    required this.idCategory,
    required this.title,
    this.description = "",
    this.amount = 0,
    this.idWallet = 0,
    required this.createdTime,
    this.isModifield = 0,
    this.modifieldTrxTime = "",
    this.categoryName = "",
    this.categoryIconName = "",
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
        categoryName,
        categoryIconName,
      ];
}
