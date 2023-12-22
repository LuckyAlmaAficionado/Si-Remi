import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/jadwal.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          NavBarRiwayatMinumObat(),
          Expanded(
            child: Obx(
              () => ListView.builder(
                  padding: const EdgeInsets.symmetric(),
                  itemCount: controller.listJadwal.length,
                  itemBuilder: (context, index) {
                    Jadwal data = controller.listJadwal[index];
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
                          trailing: GestureDetector(
                            onTap: () =>
                                controller.checkDetailInformation(index),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.pink,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.question_mark_sharp,
                                  color: Colors.white,
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
    ));
  }
}

class NavBarRiwayatMinumObat extends StatelessWidget {
  const NavBarRiwayatMinumObat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
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
                  'Riwayat Minum Obat',
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
    );
  }
}
