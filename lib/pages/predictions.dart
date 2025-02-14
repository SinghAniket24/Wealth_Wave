import 'package:flutter/material.dart';

class PredictionPage2 extends StatelessWidget {
  const PredictionPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predictions 2'),
      ),
      body: const Center(
        child: Text(
          'Content for Predictions 2 Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
