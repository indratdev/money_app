import 'package:money_app/domain/entities/category.dart';

class CategoryModel extends Category {
  int? id;
  String name;
  String iconName;
  String createdTime;
  String modifieldTime;
  int isDefault;

  CategoryModel({
    this.id,
    required this.name,
    this.iconName = "",
    this.createdTime = "",
    this.modifieldTime = "",
    this.isDefault = 0,
  }) : super(
            id: 0,
            name: "",
            iconName: "",
            createdTime: "",
            modifieldTime: "",
            isDefault: 0);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'] as int?,
        name: json['name'] as String,
        iconName: json['iconName'] as String? ?? "",
        createdTime: json['createdTime'] as String? ?? "",
        modifieldTime: json['modifieldTime'] as String? ?? "",
        isDefault: json['isDefault'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'iconName': iconName,
        'createdTime': createdTime,
        'modifieldTime': modifieldTime,
        'isDefault': isDefault,
      };
}
