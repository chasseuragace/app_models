import 'dart:convert';
import 'dart:typed_data';

import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:bson/bson.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class Image {
  final String? url;
  String? hash;
  final ObjectId? id;

  Image({this.url, this.hash, this.id});

  factory Image.fromMap(Map<String, dynamic> data) => Image(
        url: data['url'] as String?,
        hash: data['hash'],
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
    return Image(hash: "LKN]Rv%2Tw=w]~RBVZRi};RPxuwH", url: "String");
  }

  Future<String> blurHashEncode(Uint8List pixels) async {
    final image = img.decodeImage(pixels);
    final blurHash = BlurHash.encode(image!, numCompX: 4, numCompY: 3);
    return blurHash.hash;
  }

  Future<String> networkImageToHash(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    final hash = await blurHashEncode(bytes);
    return hash;
  }

  setHash() async {
    try {
      if (url != null) hash = await networkImageToHash(url!);
    } on Exception catch (e) {
      hash = "LKN]Rv%2Tw=w]~RBVZRi};RPxuwH";
    }
  }
}
