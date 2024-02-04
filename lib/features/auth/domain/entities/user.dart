import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
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
  
  const User.empty() : this(
    id: '1',
    name: '_empty.name',
    email: '_empty.email',
    password: '_empty.password'
  );

  @override
  List<Object?> get props => [id];
}
