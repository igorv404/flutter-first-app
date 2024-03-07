import 'package:flutter/material.dart';
import 'package:my_project/pages/account.dart';
import 'package:my_project/pages/home.dart';
import 'package:my_project/pages/login.dart';
import 'package:my_project/pages/registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/registration',
      routes: {
        '/': (context) => const HomePage(),
        '/registration': (context) => const RegistrationPage(),
        '/login': (context) => const LoginPage(),
        '/account': (context) => const AccountPage(),
      },
    );
  }
}
