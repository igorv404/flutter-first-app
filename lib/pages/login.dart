import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_project/components/modal_item.dart';
import 'package:my_project/models/login_info.dart';
import 'package:my_project/pages/home.dart';
import 'package:my_project/repositories/user_repository.dart';
import 'package:my_project/utils/validation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final Validation _validation = Validation();
  final UserRepository _userRepository = UserRepository();
  final LoginInfo _loginInfo = LoginInfo();
  bool _isLoginSuccess = true;
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
                      validator: (email) => _validation.validateEmail(email!),
                      onSaved: (value) {
                        _loginInfo.email = value;
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
                        _loginInfo.password = value;
                      },
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
                        if (_loginFormKey.currentState!.validate()) {
                          _loginFormKey.currentState!.save();
                          _userRepository.checkData(_loginInfo).then(
                                (value) => {
                                  setState(() {
                                    _isLoginSuccess = value;
                                  }),
                                  if (_isLoginSuccess)
                                    {
                                      if (_connectionStatus)
                                        {
                                          _userRepository.getData().then(
                                                (value) => {
                                                  if (value != null)
                                                    {
                                                      value.isRemembered =
                                                          _isCheckboxChecked,
                                                      _userRepository
                                                          .saveInStorage(value),
                                                    },
                                                },
                                              ),
                                          _modalItem.showModalMessage(
                                            context,
                                            'Success!',
                                          ),
                                          Future.delayed(
                                              const Duration(seconds: 3), () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage(),
                                              ),
                                              (route) => false,
                                            );
                                          }),
                                        }
                                      else
                                        {
                                          _modalItem.showModalMessage(
                                            context,
                                            'No Internet!',
                                          ),
                                        },
                                    }
                                  else
                                    {
                                      _modalItem.showModalMessage(
                                        context,
                                        'User not found!',
                                      ),
                                    },
                                },
                              );
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
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Visibility(
              visible: _isLoginSuccess == false,
              child: const Column(
                children: [
                  Text(
                    'Bad data',
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account? ',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Register',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushReplacementNamed(
                            context,
                            '/registration',
                          ),
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
