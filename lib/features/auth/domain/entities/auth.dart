import 'package:equatable/equatable.dart';
import './../../../../features/user/domain/entities/user.dart';

class Auth extends Equatable {
  final String token;
  final User user;

  const Auth({required this.token, required this.user});

  const Auth.empty() : this(token: '_empty.string', user: const User.empty());

  @override
  List<Object?> get props => [token, user];
}
