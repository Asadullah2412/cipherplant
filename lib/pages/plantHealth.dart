import 'package:cipherplant/pages/myPlants.dart';
import 'package:cipherplant/pages/settings.dart';
import 'package:flutter/material.dart';

class Planthealth extends StatefulWidget {
  const Planthealth({super.key});

  @override
  State<Planthealth> createState() => _PlanthealthState();
}

class _PlanthealthState extends State<Planthealth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant health'),
      ),
    );
  }
}
