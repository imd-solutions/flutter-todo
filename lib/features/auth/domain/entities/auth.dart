import 'package:equatable/equatable.dart';
import '../../../user/data/database/user_model.dart';
import './../../../../features/user/domain/entities/user.dart';

class Auth extends Equatable {
  final String token;
  final UserModel user;

  const Auth({
    required this.token,
    required this.user,
  });

  const Auth.empty()
      : this(
          token: '_empty.string',
          user: const UserModel.empty(),
        );

  @override
  List<Object?> get props => [token, user];
}
