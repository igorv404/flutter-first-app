import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: MediaQuery.of(context).size.width * 0.1,
              child: Icon(
                Icons.person,
                size: MediaQuery.of(context).size.width * 0.1,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Igor Vilkov',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Text(
              'igorvilkov404@gmail.com',
              style: TextStyle(fontSize: 22),
            ),
            RichText(
              text: const TextSpan(
                text: 'Count of reservations: ',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: '12',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            const Text(
              'Count of reservations: 12',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: const Text(
                'Log out',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
