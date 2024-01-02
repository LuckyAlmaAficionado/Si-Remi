import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simedi/app/constant/constant.dart';
import 'package:simedi/app/modules/asking/views/asking_view.dart';
import 'package:simedi/app/modules/jadwal/views/jadwal_view.dart';
import 'package:simedi/app/modules/reminder/views/reminder_view.dart';
import 'package:simedi/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(Get.width);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => await Get.offAllNamed(Routes.HOME),
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => NavBarHomeView(
                    controller: controller.searchC,
                    namaPengguna: controller.name.value,
                  )),
              const Gap(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Material(
                  color: primaryContainerColor,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Colors.white,
                    onTap: () =>
                        Get.to(AskingView(), transition: Transition.cupertino),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: Get.height * 0.1,
                      child: Row(
                        children: [
                          Image.asset('assets/images/asking.png'),
                          const Gap(20),
                          Expanded(
                            child: Text(
                              'Bagaimana keadaan kamu?',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTileMenuHome(
                      text: 'Reminder\nobat',
                      onTap: () => Get.to(ReminderView(),
                          transition: Transition.downToUp),
                      image: 'notification.png',
                    ),
                    CustomTileMenuHome(
                      text: 'Jadwal\nobat',
                      onTap: () => Get.to(JadwalView(),
                          transition: Transition.leftToRightWithFade),
                      image: 'calendar.png',
                    ),
                    CustomTileMenuHome(
                      text: 'Riwayat\nobat',
                      onTap: () => Get.toNamed(Routes.HISTORY),
                      image: 'medical-history.png',
                    ),
                    CustomTileMenuHome(
                      text: 'Logout',
                      onTap: () => controller.logout(),
                      image: 'logout.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTileMenuHome extends StatelessWidget {
  const CustomTileMenuHome({
    super.key,
    required this.text,
    required this.onTap,
    required this.image,
  });

  final String text;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryContainerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  'assets/images/$image',
                  fit: BoxFit.fill,
                  width: 50,
                )),
            const Gap(10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarHomeView extends StatelessWidget {
  const NavBarHomeView({
    super.key,
    required this.namaPengguna,
    required this.controller,
  });

  final String namaPengguna;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: (Get.height < 600) ? Get.height * 0.37 : Get.height * 0.28,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30,
            ),
            width: Get.width,
            height: (Get.height < 600) ? Get.height * 0.33 : Get.height * 0.26,
            decoration: BoxDecoration(
              color: primaryColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  color: Colors.grey.shade400,
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat datang',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    namaPengguna,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 35,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    'Jangan lupa minum obat supaya sehat',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 30,
            right: 30,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3),
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 2,
                    )
                  ]),
              child: TextField(
                controller: controller,
                style: GoogleFonts.outfit(),
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  hintText: 'Coming Soon',
                  hintStyle: GoogleFonts.outfit(),
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.search,
                      color: primaryColor,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 3,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
