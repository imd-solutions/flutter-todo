import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../../../../features/auth/presentation/cubit/authentication_cubit.dart';
import './../../../../features/auth/presentation/views/login_screen.dart';
import './../../../../shared/services/injection_container.dart';
import './../../../../shared/widgets/logo.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<AuthenticationCubit>(),
      child: Scaffold(
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
                BlocBuilder<AuthenticationCubit, AuthenticationState>(
                    builder: (BuildContext context, AuthenticationState state) {
                  if (state is AuthenticationInitial) {
                    return Container();
                  }
                  if (state is CreatingUser) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is AuthenticationError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  print('The state is: $state');
                  return Container();
                }),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller:
                        context.read<AuthenticationCubit>().nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please complete the name field';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Enter your full name'),
                  ),
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                    controller:
                        context.read<AuthenticationCubit>().emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please complete the email field';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller:
                        context.read<AuthenticationCubit>().passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please complete the password field';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      context
                          .read<AuthenticationCubit>()
                          .formKey
                          .currentState!
                          .validate();

                      if (context
                          .read<AuthenticationCubit>()
                          .formKey
                          .currentState!
                          .validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );

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
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Processing Data')),
                      // );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
