import 'package:money_app/domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  int? id;
  int isOutcome, idCategory, idWallet, isModifield;
  String title;
  String? description;
  double amount;
  String createdTime, modifieldTrxTime;
  String? categoryName, categoryIconName;

  // TransactionModel({required super.isOutcome, required super.idCategory, required super.title, required super.createdTime});

  TransactionModel({
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
    this.categoryName = "",
    this.categoryIconName = "",
  }) : super(
          isOutcome: 0,
          idCategory: 0,
          title: "",
          createdTime: "",
        );

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'] as int?,
        isOutcome: json['isOutcome'] as int,
        idCategory: json['idCategory'] as int,
        title: json['title'] as String,
        description: json['description'] as String? ?? "",
        amount: json['amount'] as double,
        idWallet: json['idWallet'] as int,
        createdTime: json['createdTime'] as String,
        isModifield: json['isModifield'] as int,
        modifieldTrxTime: json['modifieldTrxTime'] as String,
        categoryName: json['categoryName'] as String? ?? "",
        categoryIconName: json['categoryIconName'] as String? ?? "",
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'isOutcome': isOutcome,
        'idCategory': idCategory,
        'title': title,
        'description': description,
        'amount': amount,
        'idWallet': idWallet,
        'createdTime': createdTime,
        'isModifield': isModifield,
        'modifieldTrxTime': modifieldTrxTime,
        'categoryName': categoryName,
        'categoryIconName': categoryIconName,
      };
}
