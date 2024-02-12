import '../../domain/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel({
    required super.token,
    required super.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json["token"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user,
      };
}
