import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_project/components/modal_item.dart';
import 'package:my_project/models/user.dart';
import 'package:my_project/pages/login.dart';
import 'package:my_project/repositories/user_repository.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final UserRepository _userRepository = UserRepository();
  late Future<User?> _user;
  final ModalItem _modalItem = ModalItem();
  late bool _connectionStatus;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _user = _userRepository.getData();
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _userRepository.getData().then(
                      (value) => {
                        if (value != null)
                          {
                            value.isRemembered = false,
                            _userRepository.saveInStorage(value),
                          },
                      },
                    );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Log out'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<User?>(
          future: _user,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: MediaQuery.sizeOf(context).width * 0.1,
                  child: Icon(
                    Icons.person,
                    size: MediaQuery.sizeOf(context).width * 0.1,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  '${snapshot.data!.firstName} ${snapshot.data!.lastName}',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  snapshot.data!.email as String,
                  style: const TextStyle(fontSize: 22),
                ),
                Text(
                  'Count of reservations:'
                  ' ${snapshot.data!.countOfReservations}',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    if (_connectionStatus) {
                      Navigator.pushNamed(context, '/edit');
                    } else {
                      _modalItem.showModalMessage(
                        context,
                        'Turn on Internet!',
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text(
                    'Edit info',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    'Log out',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
