import 'package:equatable/equatable.dart';
import 'package:sparta/pages/_shared/util/safe_map.dart';

class CategoriesJson extends Equatable {
  const CategoriesJson._({required this.categories});

  factory CategoriesJson.fromJson(Map<String, dynamic> json) =>
      CategoriesJson._(
        categories: safeMap(
          json['categories'] as List,
          CategoryJson.fromJson,
        ),
      );

  final List<CategoryJson> categories;

  @override
  List<Object?> get props => [categories];
}

class CategoryJson extends Equatable {
  const CategoryJson._({
    required this.id,
    required this.title,
    required this.color,
  });

  factory CategoryJson.fromJson(Map<String, dynamic> json) => CategoryJson._(
        id: json['id'] as String,
        title: json['title'] as String,
        color: json['color'] as String,
      );

  final String id;
  final String title;
  final String color;

  @override
  List<Object?> get props => [id, title, color];
}
