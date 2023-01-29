import 'package:flutter/material.dart';
import 'package:semiproject_app/constants/image_strings.dart';
import 'package:semiproject_app/constants/sizes.dart';
import 'package:semiproject_app/constants/text_strings.dart';
import 'package:semiproject_app/signup/form_header_widget.dart';
import 'package:semiproject_app/signup/signup_footer_widget.dart';
import 'package:semiproject_app/signup/signup_form_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: const [
                // Header Widget 사용법
                FormHeaderWidget(
                    image: tSplashImage,
                    title: tSignUpTitle,
                    subTitle: tSignUpSubTitle),
                SignUpFormWidget(),
                SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
