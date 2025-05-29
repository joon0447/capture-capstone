import 'package:flutter/material.dart';

class FaceScreenTest extends StatelessWidget {
  const FaceScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '테스트입니다',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
