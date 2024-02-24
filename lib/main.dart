import 'package:firstapp/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import './../features/auth/presentation/cubit/authentication_cubit.dart';
import './../shared/services/injection_container.dart';
import './../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<AuthenticationCubit>(),
      child: GetMaterialApp(
        title: 'Todo Application',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        home: const HomeScreen(),
        // getPages: [
        //   GetPage(
        //       name: '/', page: () => const HomePage(), binding: TodoBinding())
        // ],
      ),
    );
  }
}
