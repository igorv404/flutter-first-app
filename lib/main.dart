import 'package:flutter/material.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _magicController = TextEditingController();
  int _counter = 0;
  bool _isBadValue = false;
  var _backgroundColor = Colors.white;

  void _changeCount() {
    setState(() {
      final magicValue = int.tryParse(_magicController.text);
      _backgroundColor = Colors.white;
      _isBadValue = false;
      if (magicValue == null) {
        if (_magicController.text == 'Avada Kedavra') {
          _counter = 0;
        } else {
          _backgroundColor = Colors.redAccent;
          _isBadValue = true;
        }
      } else {
        _counter += magicValue;
      }
      _magicController.clear();
    });
  }

  @override
  void dispose() {
    _magicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _magicController,
                decoration: const InputDecoration(
                  hintText: 'Enter your number',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Visibility(
              visible: _isBadValue,
              child: const Text(
                'You can write only convertible to int values',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeCount,
        tooltip: 'Changer',
        child: const Icon(Icons.add),
      ),
    );
  }
}
