import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simedi/app/models/akun.dart';

import '../../../models/jadwal.dart';

class HistoryController extends GetxController {
  var listJadwal = <Jadwal>[].obs;
  var tempJadwal = <Jadwal>[].obs;
  var docId = ''.obs;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  initJadwal() async {
    listJadwal.clear();
    tempJadwal.clear();
    Akun? listAkun;
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('account')
          .where('uid', isEqualTo: _auth.currentUser!.uid)
          .get();

      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((e) => e.data()).toList();

      data.forEach((element) {
        listAkun = Akun.fromJson(element);
      });

      if (listAkun!.jadwal!.isNotEmpty) {
        listAkun!.jadwal!.forEach((element) {
          if (element.status == true) {
            listJadwal.add(element);
          }
        });
      }

      docId.value = listAkun!.docId;
      print('tidak ada jadwal');
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  checkDetailInformation(int index) {
    Get.defaultDialog(
      title: 'DETAIL OBAT',
      titleStyle: GoogleFonts.outfit(
        fontWeight: FontWeight.w600,
      ),
      titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nama Obat: ${listJadwal[index].namaObat}',
            style: GoogleFonts.outfit(),
          ),
          Text(
            'Dosis Obat: ${listJadwal[index].dosisObat}',
            style: GoogleFonts.outfit(),
          ),
          Text(
            'Tanggal Minum: ${listJadwal[index].tanggal}',
            style: GoogleFonts.outfit(),
          ),
          Text(
            'Waktu Minum: ${listJadwal[index].waktu}',
            style: GoogleFonts.outfit(),
          ),
          Text(
            'Minum Ketika: ${listJadwal[index].statusMinum.split('.').last} Makan',
            style: GoogleFonts.outfit(),
          ),
        ],
      ),
    );
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    initJadwal();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
