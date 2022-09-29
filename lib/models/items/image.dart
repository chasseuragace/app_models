import 'dart:convert';

import 'package:bson/bson.dart';

class Image {
  final String? url;
  String? hash;
  final ObjectId? id;

  Image({this.url, this.hash, this.id});

  factory Image.fromMap(Map<String, dynamic> data) => Image(
        url: data['url'] as String?,
        hash: data['hash'] as String?,
        id: data['_id'] != null ? data["_id"] as ObjectId : null,
      );

  Map<String, dynamic> toMap() => {'url': url, 'hash': hash, '_id': id}
    ..removeWhere((key, value) => value == null);

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Image].
  factory Image.fromJson(String data) {
    return Image.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Image] to a JSON string.
  String toJson() => json.encode(toMap());

  factory Image.dummy() {
    return Image(hash: "String", url: "String");
  }
}
