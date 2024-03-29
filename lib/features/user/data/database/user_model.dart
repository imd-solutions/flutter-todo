import 'dart:convert';

import '../../domain/entities/user_entity.dart';
import '../../../../shared/utils/typedef.dart';

class UserModel extends UserEntity {
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

  const UserModel.empty()
      : this(
          id: '_empty.string_id',
          name: '_empty.string_name',
          email: '_empty.string_email',
          password: '_empty.string_password',
        );

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          name: map['name'] as String,
          email: map['email'] as String,
          password: map['password'] as String,
        );

  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        email: email,
        password: password,
      );

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      password: entity.password,
    );
  }

  DataMap toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };

  String toJson() => jsonEncode(toMap());
}
