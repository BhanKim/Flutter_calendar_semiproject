import 'package:flutter/material.dart';
import 'package:semiproject_app/constants/image_strings.dart';

// Header Widget
class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: const AssetImage(tSplashImage), height: size.height * 0.2),
        Text(title, style: Theme.of(context).textTheme.headline3),
        Text(subTitle, style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
