import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String password;

  // TODO: Add createdAt and updatedAt

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [id];
}
