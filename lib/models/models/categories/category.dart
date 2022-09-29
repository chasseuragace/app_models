import '../base/collections.dart';

class Category extends Coll {
  final String label, code;

  Category(this.label, this.code);
  @override
  Map<String, dynamic> toMap() {
    return {
      "label": label,
      "code": code,
    };
  }
}
