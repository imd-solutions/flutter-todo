import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? createdAt;
  final String? updatedAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.createdAt,
    this.updatedAt,
  });

  const User.empty()
      : this(
          id: '1',
          name: '_empty.name',
          email: '_empty.email',
          password: '_empty.password',
          createdAt: '2002-01-01',
          updatedAt: '2002-01-01',
        );

  @override
  List<Object?> get props => [id];
}
