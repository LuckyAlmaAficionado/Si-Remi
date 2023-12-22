import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../login/views/login_view.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: Get.width * 0.8,
                    padding: const EdgeInsets.symmetric(vertical: 30),
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
                          title: 'Username',
                          controller: controller.nameC,
                          textInputType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          icons: false,
                        ),
                        const Gap(15),
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
                              controller: controller.passC,
                              textInputType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              icons: true,
                              obsecureText: controller.isShowPass.value,
                              onTap: () => controller.isShowPass.value =
                                  !controller.isShowPass.value,
                            )),
                        const Gap(15),
                        Obx(() => CustomTextField(
                              title: 'Confirm password',
                              controller: controller.confPassC,
                              textInputType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              icons: true,
                              obsecureText: controller.isShowConfPass.value,
                              onTap: () => controller.isShowConfPass.value =
                                  !controller.isShowConfPass.value,
                            )),
                        const Gap(35),
                        CustomButton(
                          text: 'REGISTER',
                          onTap: () => controller.registerAccount(
                            controller.nameC.text,
                            controller.emailC.text,
                            controller.passC.text,
                            controller.confPassC.text,
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
                      "already have an account? ",
                      style: GoogleFonts.outfit(
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.LOGIN),
                      child: Text(
                        "Login",
                        style: GoogleFonts.outfit(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
