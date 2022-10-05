import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int? id;
  final String name;
  final String iconName;
  final String createdTime;
  final String modifieldTime;
  final int isDefault;

  const Category({
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
