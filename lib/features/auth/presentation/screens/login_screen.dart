import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/authentication_cubit.dart';
import '../widgets/input_text.dart';
import 'register_screen.dart';
import '../../../../home_screen.dart';
import '../../../../shared/widgets/logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToRegisterScreen() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        ),
      );
    }

    final TextEditingController userEmail =
        context.read<AuthenticationCubit>().emailController;

    final TextEditingController userPassword =
        context.read<AuthenticationCubit>().passwordController;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: context.read<AuthenticationCubit>().formKey,
          child: Column(
            children: <Widget>[
              const Logo(),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: InputText(
                  controller: userEmail,
                  email: true,
                  labelText: 'Email',
                  hintText: 'Please enter your email',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: InputText(
                  controller: userPassword,
                  password: true,
                  labelText: 'Password',
                  hintText: 'Please enter your password',
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
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
                        context.read<AuthenticationCubit>().userLogin(
                              email: userEmail.text,
                              password: userPassword.text,
                            );
                      }
                    },
                    child: state is LoginUserIn
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
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                  ),
                );
              }),
              const SizedBox(
                height: 130,
              ),
              TextButton(
                onPressed: () => navigateToRegisterScreen(),
                child: const Text(
                  'New user? Create account',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
