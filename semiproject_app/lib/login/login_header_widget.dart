import 'package:flutter/material.dart';
import 'package:semiproject_app/constants/image_strings.dart';
import 'package:semiproject_app/constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: const AssetImage(tSplashImage),
          height: 100,
        ),
        Text(tLoginTitle, style: Theme.of(context).textTheme.headline3),
        Text(tLoginSubTitle, style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
