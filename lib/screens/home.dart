import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home screen"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Press me"),
          onPressed: () {
            Navigator.pushNamed(context, 'detail');
          },
        ),
      ),
    );
  }
}
