import 'package:flutter/material.dart';
import 'package:my_project/models/user.dart';
import 'package:my_project/pages/account.dart';
import 'package:my_project/pages/edit.dart';
import 'package:my_project/pages/home.dart';
import 'package:my_project/pages/login.dart';
import 'package:my_project/pages/registration.dart';
import 'package:my_project/repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository userRepository = UserRepository();
  final User? user = await userRepository.getData();
  String initialRoute;
  if (user != null) {
    if (user.isRemembered) {
      initialRoute = '/';
    } else {
      initialRoute = '/login';
    }
  } else {
    initialRoute = '/registration';
  }
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: initialRoute,
      routes: {
        '/': (context) => HomePage(),
        '/registration': (context) => const RegistrationPage(),
        '/login': (context) => const LoginPage(),
        '/account': (context) => const AccountPage(),
        '/edit': (context) => const EditPage(),
      },
    );
  }
}
