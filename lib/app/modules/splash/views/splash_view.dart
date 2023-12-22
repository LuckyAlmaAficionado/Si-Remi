import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Si',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: Colors.pink,
                      fontSize: 45,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    'Remi',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w300,
                      color: Colors.pink,
                      fontSize: 45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
