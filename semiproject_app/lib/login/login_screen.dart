import 'package:flutter/material.dart';
import 'package:semiproject_app/constants/sizes.dart';
import 'package:semiproject_app/login/login_footer_widget.dart';
import 'package:semiproject_app/login/login_form_widget.dart';
import 'package:semiproject_app/login/login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            children: const [
              LoginHeaderWidget(),
              LoginForm(),
              LoginFooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
