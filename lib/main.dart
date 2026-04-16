import 'package:flutter/material.dart';

void main() {
  runApp(const CostModelApp());
}

class CostModelApp extends StatelessWidget {
  const CostModelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cost Model',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cost Model'),
        ),
        body: const Center(
          child: Text('Starter app is working'),
        ),
      ),
    );
  }
}
