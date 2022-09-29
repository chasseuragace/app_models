import 'dart:convert';

import 'package:app_models/app_models.dart';
import 'package:bson/bson.dart';

import '../base/collections.dart';

class Category extends Coll {
  final String label, code;
  final ObjectId? id;
  final Image? image;

  Category({
    required this.label,
    required this.code,
    this.image,
    this.id,
  });
  @override
  Map<String, dynamic> toMap() {
    return {"_id": id, "label": label, "code": code, "image": image?.toMap()}
      ..removeWhere((key, value) => value == null);
  }

  factory Category.dummy() {
    return Category(
      label: "String",
      code: "String",
    );
  }
  factory Category.fromJson(String data) {
    return Category.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  factory Category.fromMap(Map<String, dynamic> data) => Category(
        id: data['_id'] != null
            ? data['_id'] is ObjectId
                ? data['_id'] as ObjectId
                : ObjectId.fromHexString(data['_id'])
            : null,
        label: data['label'] as String,
        code: data['code'] as String,
      );
}
