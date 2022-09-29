class CategoryModel {
  int? id;
  String name;
  String iconName;

  CategoryModel({
    this.id,
    required this.name,
    this.iconName = "",
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'] as int?,
        name: json['name'] as String,
        iconName: json['iconName'] as String? ?? "",
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'iconName': iconName,
      };
}
