import 'package:flutter/material.dart';

class myPage extends StatefulWidget {
  const myPage({super.key});

  @override
  State<myPage> createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 41, 35, 35),
        title: Image.asset(
          'images/bdlogo.png',
          width: 300,
          height: 50,
        ),
      ),
    );
  }
}
