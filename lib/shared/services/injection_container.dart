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
  locator.registerFactory(() => AuthenticationCubit(createUser: locator()));

  // Usecases
  locator.registerLazySingleton(() => CreateUser(locator()));
  locator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(locator()));

  // Datasources
  locator.registerLazySingleton<AuthenticationRemoteDatasource>(
      () => AuthenticationRemoteDatasourceImpl(locator()));

  // External Dependencies
  locator.registerLazySingleton(http.Client.new);
}
