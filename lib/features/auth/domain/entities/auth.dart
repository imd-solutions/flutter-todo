import 'package:equatable/equatable.dart';
import '../../../user/data/database/user_model.dart';

class Auth extends Equatable {
  final String token;
  final UserModel user;

  const Auth({
    required this.token,
    required this.user,
  });

  @override
  List<Object?> get props => [token, user];
}
