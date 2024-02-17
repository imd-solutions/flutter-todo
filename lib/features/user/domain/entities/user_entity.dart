import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? createdAt;
  final String? updatedAt;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id];
}
