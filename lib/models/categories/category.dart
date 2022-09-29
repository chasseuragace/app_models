import 'dart:convert';

import 'package:app_models/app_models.dart';
import 'package:bson/bson.dart';

import '../base/collections.dart';

class Category extends Coll {
  final String label, code;
  final ObjectId? id;
  final Image? image;
  List<Category>? children = [];
  String? tempId;

  Category({
    required this.label,
    required this.code,
    this.image,
    this.id,
    this.children,
  });
  @override
  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "label": label,
      "code": code,
      "image": image?.toMap(),
      "children": children?.map((e) => e.toMap()).toList()
    }..removeWhere((key, value) => value == null);
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
      label: data['label'] ?? "String",
      children: data['children'] != null
          ? (data['children'] as List).map((e) => Category.fromMap(e)).toList()
          : [],
      code: data['code'] ?? "String",
      image: data['image'] != null ? Image.fromMap(data["image"]) : null);

  static List<Category> listToTree(List<Category> list) {
    Map<String, int> map = {};
    Category node;
    List<Category> roots = [];
    int i;

    for (i = 0; i < list.length; i += 1) {
      //code index map
      map[list[i].code.toString()] = i; // initialize the map

    }

    for (i = 0; i < list.length; i += 1) {
      node = list[i];
      var parentId = (node.parent);
      print("$parentId for ${node.code}");

      if (parentId != "0") {
        node.children = [];
        // if you have dangling branches check that map[parentId] exists
        list[map[parentId]!].children?.add(node);
      } else {
        roots.add(node);
      }
    }

    return roots;
  }

  String get parent {
    var j = code.split("-")..removeLast();
    return (j.isEmpty ? ["0"] : j).join("-");
  }
}
