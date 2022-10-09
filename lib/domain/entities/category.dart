import 'package:equatable/equatable.dart';

class Category extends Equatable {
  int? id;
  String name;
  String iconName;
  String createdTime;
  String modifieldTime;
  int isDefault;

  Category({
    this.id,
    required this.name,
    required this.iconName,
    required this.createdTime,
    required this.modifieldTime,
    required this.isDefault,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        iconName,
        createdTime,
        modifieldTime,
        isDefault,
      ];
}
