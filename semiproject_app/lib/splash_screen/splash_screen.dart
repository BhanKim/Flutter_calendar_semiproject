import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semiproject_app/constants/colors.dart';
import 'package:semiproject_app/constants/image_strings.dart';
import 'package:semiproject_app/constants/sizes.dart';
import 'package:semiproject_app/constants/text_strings.dart';
import 'package:semiproject_app/controllers/splash_screen_controller.dart';
import 'package:semiproject_app/fade_in_animation/animation_design.dart';
import 'package:semiproject_app/fade_in_animation/fade_in_animation_model.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splashController = Get.put(SplashScreenController());
    splashController.startSplashAnimation();
    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 1600,
            animate: TAnimatePosition(
              topAfter: 0,
              topBefore: -30,
              leftBefore: -30,
              leftAfter: 0,
            ),
            child: const Image(image: AssetImage(tSplashTopIcon)),
          ),
          TFadeInAnimation(
            durationInMs: 2000,
            animate: TAnimatePosition(
                topBefore: 80,
                topAfter: 80,
                leftAfter: tDefaultSize,
                leftBefore: -80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tAppName, style: Theme.of(context).textTheme.headline3),
                Text(tAppTagLine, style: Theme.of(context).textTheme.headline2)
              ],
            ),
          ),
          TFadeInAnimation(
            durationInMs: 2400,
            animate: TAnimatePosition(bottomBefore: 0, bottomAfter: 100),
            child: const Image(image: AssetImage(tSplashImage)),
          ),
          TFadeInAnimation(
            durationInMs: 2400,
            animate: TAnimatePosition(
                bottomBefore: 0,
                bottomAfter: 60,
                rightBefore: tDefaultSize,
                rightAfter: tDefaultSize),
            child: Container(
              width: tSplashContainerSize,
              height: tSplashContainerSize,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: tPrimaryColor),
            ),
          ),
          // Obx(
          //   () => AnimatedPositioned(
          //     duration: const Duration(milliseconds: 1600),
          //     top: splashController.animate.value ? 0 : -30,
          //     left: splashController.animate.value ? 0 : -30,
          //     child: const Image(
          //       image: AssetImage(tSplashTopIcon),
          //       width: 150,
          //       height: 150,
          //     ),
          //   ),
          // ),
          // Obx(
          //   () => AnimatedPositioned(
          //     duration: const Duration(milliseconds: 1600),
          //     top: 120,
          //     left: splashController.animate.value ? tDefaultSize : -80,
          //     child: AnimatedOpacity(
          //       duration: const Duration(milliseconds: 1600),
          //       opacity: splashController.animate.value ? 1 : 0,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             tAppName,
          //             style: Theme.of(context).textTheme.headline6,
          //           ),
          //           Text(
          //             tAppTagLine,
          //             style: Theme.of(context).textTheme.headline5,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Obx(
          //   () => AnimatedPositioned(
          //     duration: const Duration(milliseconds: 2400),
          //     bottom: splashController.animate.value ? 300 : 0,
          //     child: AnimatedOpacity(
          //       duration: const Duration(milliseconds: 2000),
          //       opacity: splashController.animate.value ? 1 : 0,
          //       child: const Image(image: AssetImage(tSplashImage)),
          //     ),
          //   ),
          // ),
          // Obx(
          //   () => AnimatedPositioned(
          //     duration: const Duration(milliseconds: 2400),
          //     bottom: splashController.animate.value ? 60 : 0,
          //     right: tDefaultSize,
          //     child: AnimatedOpacity(
          //       duration: const Duration(milliseconds: 2000),
          //       opacity: splashController.animate.value ? 1 : 0,
          //       child: Container(
          //         width: tSplashContainerSize,
          //         height: tSplashContainerSize,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(100),
          //             color: tPrimaryColor),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// END
