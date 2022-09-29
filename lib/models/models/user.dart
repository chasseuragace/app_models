import 'dart:convert';

import 'package:bson/bson.dart';

import 'base/collections.dart';

class User extends Coll {
  ROLE? role;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json['_id'] != null ? json['_id'] as ObjectId : null,
        email: json['email'] as String,
        role: ROLE.values.singleWhere(
            (element) =>
                element.name.toLowerCase() ==
                json["role"].toString().toLowerCase(),
            orElse: () => ROLE.customer),
        isVerified: ((json['is_verified']) ?? false) as bool,
        hashedPassword: json['hashed_password']?.toString(),
        name: json['name']?.toString(),
        password:json["password"],
        code: json['code']?.toString(),
      );
  User({
    required this.email,
    this.isVerified = false,
    this.role = ROLE.customer,
    this.hashedPassword,
    this.name,
    this.code,
    this.password
    this.id,
  });

  final String? email;
  final String? hashedPassword;
  final ObjectId? id;
  final String? name;
  final String? code;
  final bool isVerified;
  final String? password;

  String toJson() => json.encode(toMap());
  @override
  Map<String, dynamic> toMap() => {
        '_id': id,
        'email': email,
        'code': code,
        'role': role?.name,
        'name': name,
        'password':password,
        'hashed_password': hashedPassword,
        'is_verified': isVerified
      }..removeWhere((key, value) => value == null);

  Map<String, dynamic> toSecureMap() =>
      {'email': email, 'name': name, 'is_verified': isVerified};
}
