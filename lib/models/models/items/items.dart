import 'dart:convert';

import 'package:bson/bson.dart';

import '../base/collections.dart';
import 'image.dart';

class Items extends Coll {
  final String? name;
  final List<String>? colors;
  final List<String>? sizes;
  final double? price;
  final String? brand;
  final List<Image>? image;
  final ObjectId? id;
  const Items(
      {this.name,
      this.colors,
      this.sizes,
      this.price,
      this.brand,
      this.image,
      this.id});

  factory Items.dummy() {
    return Items(
        brand: "String",
        colors: ["String"],
        image: [Image.dummy()],
        name: "String",
        price: 1234.00,
        sizes: ["L", "XL"]);
  }

  factory Items.fromMap(Map<String, dynamic> data) => Items(
        id: data['_id'] != null ? data['_id'] as ObjectId : null,
        name: data['name'] != null ? data['name'] as String : null,
        colors: data['colors'] != null
            ? (data['colors'] as List).cast<String>()
            : null,
        sizes: data['sizes'] != null
            ? (data['sizes'] as List).cast<String>()
            : null,
        price: data['price'] != null
            ? double.tryParse(data['price'].toString())
            : null,
        brand: data['brand'] != null ? data['brand'] as String : null,
        image: data['image'] != null
            ? (data['image'] as List<dynamic>?)
                ?.map((e) => Image.fromMap(e as Map<String, dynamic>))
                .toList()
            : null,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'colors': colors,
        'sizes': sizes,
        'price': price,
        'brand': brand,
        'image': image?.map((e) => e.toMap()).toList(),
      }..removeWhere((key, value) => value == null);

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Items].
  factory Items.fromJson(String data) {
    return Items.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Items] to a JSON string.
  String toJson() => json.encode(toMap());
}
