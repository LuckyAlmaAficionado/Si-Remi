// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simedi/app/constant/constant.dart';
import 'package:simedi/app/models/jadwal.dart';

import '../controllers/jadwal_controller.dart';

class JadwalView extends GetView<JadwalController> {
  const JadwalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(JadwalController());
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            Container(
              color: primaryColor,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: SafeArea(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          color: Colors.white,
                          Icons.arrow_back_ios,
                          size: 15,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Jadwal Minum Obat',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                    padding: const EdgeInsets.symmetric(),
                    itemCount: controller.listJadwal.value.length,
                    itemBuilder: (context, index) {
                      Jadwal data = controller.listJadwal.value[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              data.namaObat,
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              "Dosis obat: ${data.dosisObat}",
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                            trailing: Material(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () => controller.dialogBoxConfirm(index),
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(thickness: 2),
                        ],
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
