import 'package:flutter/widgets.dart';

class CategoryModel {
  final String id;
  final String name;
  final String? nameEn;
  final String? imageUrl;
  final String? description;
  final String? descriptionVi;
  final String? descriptionEn;

  CategoryModel({
    required this.id,
    required this.name,
    this.nameEn,
    this.imageUrl,
    this.description,
    this.descriptionVi,
    this.descriptionEn,
  });

  String getName(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'en' && nameEn != null
      ? nameEn!
      : name;

  String? getDescription(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'en' &&
          descriptionEn != null
      ? descriptionEn
      : descriptionVi ?? description;

  CategoryModel copyWith({
    String? id,
    String? name,
    String? nameEn,
    String? imageUrl,
    String? description,
    String? descriptionVi,
    String? descriptionEn,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      descriptionVi: descriptionVi ?? this.descriptionVi,
      descriptionEn: descriptionEn ?? this.descriptionEn,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameEn': nameEn,
      'imageUrl': imageUrl,
      'description': description,
      'descriptionVi': descriptionVi,
      'descriptionEn': descriptionEn,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nameEn: json['nameEn'] as String?,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      descriptionVi: json['descriptionVi'] as String?,
      descriptionEn: json['descriptionEn'] as String?,
    );
  }
}
