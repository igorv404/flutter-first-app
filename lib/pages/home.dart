import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_project/components/establishmentItem.dart';
import 'package:my_project/models/establishment.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Establishment> _list = [
    Establishment(
      1,
      '36Po',
      'https://namori.com.ua/img/service/eab280bc567f2f7ddf8a77b1b1a55d40/2-desc-5e5a2727c3d7c.jpg',
      'Rynok square, 36, Lviv',
      4,
    ),
    Establishment(
      2,
      'Kreventka',
      'https://docs-s2p.s3.eu-west-1.amazonaws.com/backgroundimage/2E423C7C105458089EA2BCBEFC426651.jpeg',
      '5 Virmenska street, Lviv',
      2,
    ),
    Establishment(
      3,
      'MAREVO',
      'https://lviv.virtual.ua/images/510673/',
      'Rynok square, 36, Lviv',
      3,
    ),
    Establishment(
      4,
      'Salalat',
      'https://cdn-media.choiceqr.com/prod-eat-salalat-main/promo/desktop-ylZfktL-WnDJxrj-qDLQZeH.webp',
      'Soborna ploshcha, 2, Lviv',
      3,
    ),
    Establishment(
      5,
      'Red Pepper',
      'https://ua.igotoworld.com/frontend/webcontent/websites/1/images/1930064_800x600_red_pepper_2.jpg',
      '5 Sichovyh Striltsiv street, Lviv',
      4,
    ),
    Establishment(
      6,
      'Grand Cafe Leopolis',
      'https://reston.ua/uploads/img/zavedeniya/f1cef54.jpg',
      'Rynok, 1, Lviv',
      4,
    ),
  ];
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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/account');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                'All establishments',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              if (_connectionStatus)
                Column(
                  children: [
                    for (Establishment establishment in _list)
                      EstablishmentItem(establishment: establishment),
                  ],
                )
              else
                const Text(
                  'No content',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
