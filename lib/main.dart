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
  Color _backgroundColor = Colors.white;
  MainAxisAlignment _contentPosition = MainAxisAlignment.center;

  void _changeCount() {
    setState(() {
      final magicValue = int.tryParse(_magicController.text);
      _backgroundColor = Colors.white;
      _isBadValue = false;
      if (magicValue == null) {
        switch (_magicController.text) {
          case 'Avada Kedavra': {
              _counter = 0;
              break;
          }
          case 'Wingardium leviosa': {
              _contentPosition = MainAxisAlignment.start;
              break;
          }
          case 'Accio default view': {
              _contentPosition = MainAxisAlignment.center;
              break;
          }
          default: {
              _backgroundColor = Colors.redAccent;
              _isBadValue = true;
              break;
          }
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
          mainAxisAlignment: _contentPosition,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
