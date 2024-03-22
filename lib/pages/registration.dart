import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_project/components/modal_item.dart';
import 'package:my_project/models/user.dart';
import 'package:my_project/pages/home.dart';
import 'package:my_project/repositories/user_repository.dart';
import 'package:my_project/utils/validation.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final Validation _validation = Validation();
  final UserRepository _userRepository = UserRepository();
  final User _user = User(1);
  bool _isCheckboxChecked = false;
  final ModalItem _modalItem = ModalItem();
  late bool _connectionStatus;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    result = await _connectivity.checkConnectivity();
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result[0] != ConnectivityResult.none;
    });
  }

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
                width: MediaQuery.of(context).size.width * 0.9,
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
                          password != _passwordController.text ||
                                  password!.trim().isEmpty
                              ? 'Confirm password'
                              : null,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _isCheckboxChecked,
                          onChanged: (value) {
                            setState(() {
                              _isCheckboxChecked = value!;
                            });
                          },
                        ),
                        const Text('Remember Me'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_registrationFormKey.currentState!.validate()) {
                          if (_connectionStatus) {
                            _registrationFormKey.currentState!.save();
                            _user.isRemembered = _isCheckboxChecked;
                            _userRepository.saveInStorage(_user);
                            _modalItem.showModalMessage(context, 'Success!');
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                                (route) => false,
                              );
                            });
                          } else {
                            _modalItem.showModalMessage(
                                context, 'No Internet!');
                          }
                        } else {
                          _modalItem.showModalMessage(context, 'Failed!');
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
