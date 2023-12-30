import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simedi/app/constant/constant.dart';
import 'package:simedi/app/routes/app_pages.dart';
import 'package:simedi/app/widgets/custom_button.dart';
import 'package:simedi/app/widgets/custom_textfield.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: Get.width * 0.8,
                height: Get.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomLogoSiRemi(
                      fontSize: 30,
                    ),
                    const Gap(20),
                    CustomTextField(
                      title: 'Email',
                      controller: controller.emailC,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      icons: false,
                    ),
                    const Gap(15),
                    Obx(() => CustomTextField(
                          title: 'Password',
                          controller: controller.passwordC,
                          textInputType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          icons: true,
                          obsecureText: controller.isShowPass.value,
                          onTap: () => controller.isShowPass.value =
                              !controller.isShowPass.value,
                        )),
                    const Gap(35),
                    CustomButton(
                      text: 'LOGIN',
                      onTap: () => controller.login(
                        controller.emailC.text,
                        controller.passwordC.text,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "don't have account? ",
                  style: GoogleFonts.outfit(
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.REGISTER),
                  child: Text(
                    "Register",
                    style: GoogleFonts.outfit(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomLogoSiRemi extends StatelessWidget {
  const CustomLogoSiRemi({
    super.key,
    required this.fontSize,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Si',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            color: primaryColor,
            fontSize: fontSize,
          ),
        ),
        const Gap(4),
        Text(
          'Remi',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w300,
            color: primaryColor,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
