import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import './../../../../features/auth/domain/usecases/user_login.dart';
import './../../../../shared/utils/typedef.dart';
import './../../data/models/auth_model.dart';
import '../../domain/usecases/create_user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final CreateUserUseCase _createUser;
  final UserLoginUseCase _userLogin;

  AuthenticationCubit({
    required CreateUserUseCase createUser,
    required UserLoginUseCase userLogin,
  })  : _createUser = createUser,
        _userLogin = userLogin,
        super(const AuthenticationInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ResultFutureVoid createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const CreatingUser());

    final result = await _createUser(CreateUserParams(
      name: name,
      email: email,
      password: password,
    ));

    result.fold(
      (failure) {
        emit(
          AuthenticationError(
            message: failure.message,
            statusCode: failure.statusCode,
          ),
        );
      },
      (_) => emit(
        const UserCreated(),
      ),
    );

    return const Right(null);
  }

  ResultFuture<AuthModel> userLogin({
    required String email,
    required String password,
  }) async {
    emit(const LoginUserIn());
    final result = await _userLogin(
      UserLoginParams(
        email: email,
        password: password,
      ),
    );

    result.fold(
      (failure) {
        print(failure);
        emit(
          AuthenticationError(
              message: failure.message, statusCode: failure.statusCode),
        );
      },
      (_) => emit(
        const UserLoggedIn(),
      ),
    );

    return const Right(AuthModel.empty());
  }
}
