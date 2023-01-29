import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semiproject_app/view/main_page.dart';

import '../constants/colors.dart';

class bossPage extends StatefulWidget {
  const bossPage({super.key});

  @override
  State<bossPage> createState() => _bossPageState();
}

class _bossPageState extends State<bossPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 41, 35, 35),
        backgroundColor: tOnBoardingPage1Color,
        title: Image.asset(
          'images/bdlogo.png',
          width: 300,
          height: 50,
        ),
      ),
      body: ColoredBox(
        color: Color.fromARGB(255, 41, 35, 35),
        child: Column(
          children: [
            Image.asset(
              'images/bdbosstime.jpeg',
              width: 500,
              height: 800,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(const mainPage());
        },
        label: Icon(
          Icons.arrow_back,
          color: Colors.grey[350],
        ),
      ),
    );
  }
}
