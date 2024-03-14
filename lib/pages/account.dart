import 'package:flutter/material.dart';
import 'package:my_project/models/user.dart';
import 'package:my_project/pages/login.dart';
import 'package:my_project/utils/secure_storage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final SecureStorage _secureStorage = SecureStorage();
  late Future<User?> _user;

  @override
  void initState() {
    super.initState();
    _user = _secureStorage.getUser();
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
                      fontSize: 26, fontWeight: FontWeight.bold),
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
                    Navigator.pushNamed(context, '/edit');
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    );
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
