import 'package:firstapp/features/auth/presentation/widgets/user_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../../../features/auth/presentation/widgets/input_text.dart';
import './../../../../shared/widgets/logo.dart';
import './../cubit/authentication_cubit.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToPage() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }

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
                  controller:
                      context.read<AuthenticationCubit>().nameController,
                  labelText: 'Name',
                  hintText: 'Please enter your full name',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: InputText(
                  controller:
                      context.read<AuthenticationCubit>().emailController,
                  email: true,
                  labelText: 'Email',
                  hintText: 'Please enter your email address',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: InputText(
                  controller:
                      context.read<AuthenticationCubit>().passwordController,
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
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        if (context
                            .read<AuthenticationCubit>()
                            .formKey
                            .currentState!
                            .validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          // if (state is CreatingUser) {

                          // }

                          context.read<AuthenticationCubit>().createUser(
                              name: context
                                  .read<AuthenticationCubit>()
                                  .nameController
                                  .text,
                              email: context
                                  .read<AuthenticationCubit>()
                                  .emailController
                                  .text,
                              password: context
                                  .read<AuthenticationCubit>()
                                  .passwordController
                                  .text);
                        }

                        UserAlerts.show(context, 'We are family', 'error');

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   UserAlerts()
                        // );
                      },
                      child: state is CreatingUser
                          ? const SizedBox(
                              height: 10.0,
                              width: 10.0,
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                            )
                          : const Text(
                              'Register',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 100,
              ),
              TextButton(
                onPressed: () => navigateToPage(),
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
