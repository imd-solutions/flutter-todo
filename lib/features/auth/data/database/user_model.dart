import 'dart:convert';

import '../../../../features/auth/domain/entities/user.dart';
import '../../../../shared/utils/typedef.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.password,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.email,
    );
  }

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          email: map['email'] as String,
          password: map['password'] as String,
        );

  DataMap toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };

  String toJson() => jsonEncode(toMap());
}
