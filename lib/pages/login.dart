import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Form(
              key: _loginFormKey,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Enter your email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Enter your password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      ),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account? ',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Register',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushReplacementNamed(context, '/registration'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
