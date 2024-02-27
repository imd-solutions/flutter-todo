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
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  // if (state is AuthenticationInitial) {
                  //   print('The initital state is: $state');
                  //   return Container();
                  // } else if (state is CreatingUser) {
                  //   print('The creating user state is: $state');
                  //   return const Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  // } else if (state is UserCreated) {
                  //   print('The user created state is: $state');
                  //   return const Center(
                  //     child: Text('DONE!'),
                  //   );
                  // } else if (state is AuthenticationError) {
                  //   print('The authentication state is: $state');
                  //   return Center(
                  //     child: Text(state.message),
                  //   );
                  // } else {
                  //   return Container();
                  // }

                  return Container(
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
                onPressed: () {
                  Navigator.pushReplacement(
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
    );
  }
}
