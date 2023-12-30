import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simedi/app/widgets/custom_button.dart';

import '../controllers/asking_controller.dart';

class AskingView extends GetView<AskingController> {
  const AskingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AskingController());
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: CarouselSlider(
          carouselController: controller.carouselController,
          items: controller.question
              .map((element) => SafeArea(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              element.question,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.outfit(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            const Gap(30),
                            CustomButton(
                              text: element.ans_1,
                              onTap: () => controller.inputAnswerFromUser(1),
                            ),
                            const Gap(10),
                            CustomButton(
                              text: element.ans_2,
                              onTap: () => controller.inputAnswerFromUser(2),
                            ),
                            const Gap(10),
                            CustomButton(
                              text: element.ans_3,
                              onTap: () => controller.inputAnswerFromUser(3),
                            ),
                          ],
                        )),
                  ))
              .toList(),
          options: CarouselOptions(
            height: Get.height,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              print(index);
            },
          ),
        ),
      ),
    );
  }
}
