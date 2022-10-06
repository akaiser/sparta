import 'dart:ui' show Color;

import 'package:equatable/equatable.dart';
import 'package:sparta/pages/_shared/extensions/color.dart';
import 'package:sparta/pages/_shared/models/categories_json.dart';

class CategoryModel extends Equatable {
  const CategoryModel._({
    required this.id,
    required this.title,
    required this.color,
  });

  factory CategoryModel.fromJson(CategoryJson json) => CategoryModel._(
        id: json.id,
        title: json.title,
        color: json.color.fromHex,
      );

  final String id;
  final String title;
  final Color color;

  @override
  List<Object?> get props => [id, title, color];
}
