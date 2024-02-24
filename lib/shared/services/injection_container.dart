import 'package:firstapp/features/auth/domain/usecases/user_login.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import './../../features/auth/data/datasource/authentication_remote_datasource.dart';
import './../../features/auth/presentation/cubit/authentication_cubit.dart';
import './../../features/auth/domain/usecases/create_user.dart';
import './../../features/auth/data/datasource/authentication_remote_datasource_impl.dart';
import './../../features/auth/data/repositories/authentication_repository_impl.dart';
import './../../features/auth/domain/repositories/authentication_repository.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Application Login
  locator.registerFactory(
      () => AuthenticationCubit(createUser: locator(), userLogin: locator()));

  // Usecases
  locator.registerLazySingleton(() => CreateUserUseCase(locator()));
  locator.registerLazySingleton(() => UserLoginUseCase(locator()));
  locator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(locator()));
  locator.registerLazySingleton(() => AuthenticationRepositoryImpl(locator()));
  // Datasources
  locator.registerLazySingleton<AuthenticationRemoteDatasource>(
      () => AuthenticationRemoteDatasourceImpl(locator()));
  locator.registerLazySingleton(
      () => AuthenticationRemoteDatasourceImpl(locator()));

  // External Dependencies
  locator.registerLazySingleton(http.Client.new);
}
