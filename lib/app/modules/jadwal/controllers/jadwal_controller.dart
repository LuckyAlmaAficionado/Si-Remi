import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/akun.dart';
import '../../../models/jadwal.dart';

class JadwalController extends GetxController {
  var listJadwal = <Jadwal>[].obs;
  var tempJadwal = <Jadwal>[].obs;
  var docId = ''.obs;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  dialogBoxConfirm(int index) {
    Get.defaultDialog(
      title: 'anda yakin?',
      titleStyle: GoogleFonts.outfit(
        fontWeight: FontWeight.w600,
      ),
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      content: Text(
        'apakah anda yakin sudah meminum obat nya?',
        textAlign: TextAlign.center,
        style: GoogleFonts.outfit(),
      ),
      cancel: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: Text(
              'Belum',
              style: GoogleFonts.outfit(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      confirm: GestureDetector(
        onTap: () {
          updateStatusMinumObat(index);
          return Get.back();
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: Text(
              'Sudah',
              style: GoogleFonts.outfit(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  updateStatusMinumObat(int index) async {
    Get.back();
    listJadwal[index].status = true;

    listJadwal.forEach((element) {
      print(element.namaObat);
    });

    tempJadwal.addAll(listJadwal);

    try {
      final reference = _firestore.collection('account').doc(docId.value);
      reference.update({
        "jadwal": tempJadwal.map((element) => element.toJson()).toList(),
      }).then((value) => print('DocumentSnapshot successfully updated!'),
          onError: (error) => print('Error updating document $error'));

      initJadwal();
      Get.snackbar('Congratulations', 'semoga anda cepat sembuh');
    } on FirebaseException catch (e) {
      throw ('Error: $e');
    }
  }

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
        // var temp =
        //     listAkun!.jadwal!.takeWhile((e) => e.status != true).toList();
        listAkun!.jadwal!.forEach((element) {
          if (element.status == false) {
            listJadwal.add(element);
          } else {
            tempJadwal.add(element);
          }
        });
        // print(temp);
        // listJadwal.value = listAkun!.jadwal!;
      }

      docId.value = listAkun!.docId;
      print('tidak ada jadwal');
    } on FirebaseException catch (e) {
      throw e;
    }
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
