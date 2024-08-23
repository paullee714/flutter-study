import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello World'),
        ),
        body: const Center(
          child: CustomContainer(),
        ),
      ),
    ),
  );
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: const Center(
          child: Text('Hello World'),
        ),
    );
  }
}
