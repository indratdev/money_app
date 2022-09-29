import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String iconName;

  const Category({
    required this.id,
    required this.name,
    required this.iconName,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        iconName,
      ];
}
