import 'dart:convert';

import 'package:firstapp/features/user/data/database/user_model.dart';

import '../../domain/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel({
    required super.token,
    required super.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json["token"],
        user: UserModel(
          id: json["user"]['id'],
          name: json["user"]['name'],
          email: json["user"]['email'],
          password: json["user"]['password'],
        ),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user,
      };
}
