import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simedi/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => NavBarHomeView(
                  controller: controller.searchC,
                  namaPengguna: controller.name.value,
                )),
            const Gap(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTileMenuHome(
                    icons: Icons.timelapse_rounded,
                    text: 'reminder\nobat',
                    onTap: () => Get.toNamed(Routes.REMINDER),
                  ),
                  CustomTileMenuHome(
                    text: 'jadwal\nobat',
                    onTap: () => Get.toNamed(Routes.JADWAL),
                    icons: Icons.calendar_month,
                  ),
                  CustomTileMenuHome(
                    text: 'Riwayat\nobat',
                    onTap: () => Get.toNamed(Routes.HISTORY),
                    icons: Icons.history,
                  ),
                  CustomTileMenuHome(
                    text: 'Logout',
                    onTap: () => controller.logout(),
                    icons: Icons.logout,
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

class CustomTileMenuHome extends StatelessWidget {
  const CustomTileMenuHome({
    super.key,
    required this.text,
    required this.onTap,
    required this.icons,
  });

  final String text;
  final Function() onTap;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icons,
                size: 35,
                color: Colors.white,
              ),
            ),
            const Gap(10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(),
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
      height: Get.height * 0.28,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30,
            ),
            width: Get.width,
            height: Get.height * 0.26,
            decoration: BoxDecoration(
              color: Colors.pink,
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
                      offset: Offset(0, 4),
                      color: Colors.grey.shade400,
                      blurRadius: 10,
                      spreadRadius: 1,
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
                      color: Colors.pink,
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
