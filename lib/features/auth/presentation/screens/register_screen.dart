import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../../../features/auth/presentation/widgets/input_text.dart';
import './../../../../features/auth/presentation/widgets/user_alerts.dart';
import './../../../../shared/widgets/logo.dart';
import './../cubit/authentication_cubit.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToLoginScreen() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }

    final TextEditingController userName =
        context.read<AuthenticationCubit>().nameController;

    final TextEditingController userEmail =
        context.read<AuthenticationCubit>().emailController;

    final TextEditingController userPassword =
        context.read<AuthenticationCubit>().passwordController;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Register Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: context.read<AuthenticationCubit>().formKey,
          child: Column(
            children: <Widget>[
              const Logo(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: InputText(
                  controller: userName,
                  labelText: 'Name',
                  hintText: 'Please enter your full name',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: InputText(
                  controller: userEmail,
                  email: true,
                  labelText: 'Email',
                  hintText: 'Please enter your email address',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: InputText(
                  controller: userPassword,
                  password: true,
                  labelText: 'Password',
                  hintText: 'Please enter a password',
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  return Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (context
                            .read<AuthenticationCubit>()
                            .formKey
                            .currentState!
                            .validate()) {
                          context.read<AuthenticationCubit>().createUser(
                                name: userName.text,
                                email: userEmail.text,
                                password: userPassword.text,
                              );
                        }

                        if (state is UserCreated) {
                          UserAlerts.show(context,
                              'User has been created successfully', 'success');
                        }

                        if (state is AuthenticationError) {
                          UserAlerts.show(context,
                              'There has been an error somewhere', 'error');
                        }
                      },
                      child: state is CreatingUser
                          ? const SizedBox(
                              height: 15.0,
                              width: 15.0,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 100,
              ),
              TextButton(
                onPressed: () => navigateToLoginScreen(),
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
