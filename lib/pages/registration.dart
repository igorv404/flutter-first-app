import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_project/models/user.dart';
import 'package:my_project/pages/home.dart';
import 'package:my_project/utils/secure_storage.dart';

import 'package:my_project/utils/validation.dart';

class RegistrationPage extends StatelessWidget {
  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final Validation _validation = Validation();
  final SecureStorage _secureStorage = SecureStorage();
  final User _user = User(1);

  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Registration',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Form(
              key: _registrationFormKey,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Enter your name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (name) => name!.trim().length < 2
                          ? 'Name should be a least 2 symbols'
                          : null,
                      onSaved: (value) {
                        _user.firstName = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Enter your surname',
                        border: OutlineInputBorder(),
                      ),
                      validator: (surname) => surname!.trim().length < 2
                          ? 'Surname should be a least 2 symbols'
                          : null,
                      onSaved: (value) {
                        _user.lastName = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Enter your email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (email) => _validation.validateEmail(email!),
                      onSaved: (value) {
                        _user.email = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Enter your password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (password) =>
                          _validation.validatePassword(password!),
                      onSaved: (value) {
                        _user.password = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Enter your password again',
                        border: OutlineInputBorder(),
                      ),
                      validator: (password) =>
                          password! != _passwordController.text ||
                                  password.trim().isEmpty
                              ? 'Confirm password'
                              : null,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_registrationFormKey.currentState!.validate()) {
                          _registrationFormKey.currentState!.save();
                          _secureStorage.saveUser(_user);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                      ),
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Login',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          Navigator.pushReplacementNamed(context, '/login'),
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
