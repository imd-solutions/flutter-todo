import './../../../../features/user/data/database/user_model.dart';
import '../../domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.token,
    required super.user,
  });

  const AuthModel.empty()
      : this(
          token: '_empty.string_token',
          user: const UserModel.empty(),
        );

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

  AuthEntity toEntity() => AuthEntity(
        token: token,
        user: user,
      );
}
