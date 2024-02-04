import './../../../../features/auth/data/database/user_model.dart';

abstract class AuthenticationRemoteDatasource {

Future<void> createUser({
  required String name, 
  required String email, 
  required String password
});

Future<List<UserModel>> getUsers();

}