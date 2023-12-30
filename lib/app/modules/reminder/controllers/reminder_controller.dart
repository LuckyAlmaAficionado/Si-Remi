// ignore_for_file: invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simedi/app/constant/constant.dart';
import 'package:simedi/app/controller/nofitication.dart';
import 'package:simedi/app/models/akun.dart';
import 'package:simedi/app/models/jadwal.dart';
import 'package:simedi/app/routes/app_pages.dart';

enum Status { Sebelum, Sesudah, Ketika }

class ReminderController extends GetxController {
  DateTime pickerTime = DateTime.now();
  DateTime pickerDate = DateTime.now();
  Rx<Status> statusMinumObat = Status.Sebelum.obs;
  var listJadwal = <Jadwal>[].obs;
  var docId = ''.obs;
  late TextEditingController namaObatC;
  late TextEditingController dosisObatC;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  initJadwal() async {
    listJadwal.clear();
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
        print('ada jadwal');
        listJadwal.value = listAkun!.jadwal!;
      }

      docId.value = listAkun!.docId;
      print('tidak ada jadwal');
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  addJadwalMinumObat(
    String namaObat,
    String dosisObat,
    Status statusMinum,
    String waktu,
    String tanggal,
  ) async {
    try {
      final reference = _firestore.collection('account').doc(docId.value);

      listJadwal.value.add(Jadwal(
        namaObat: namaObat,
        dosisObat: dosisObat,
        statusMinum: statusMinum.toString(),
        waktu: waktu,
        tanggal: tanggal,
        status: false,
      ));

      reference.update({
        "jadwal": listJadwal.value.map((e) => e.toJson()).toList(),
      }).then((value) => print('DocumentSnapshot successfully updated!'),
          onError: (error) => print('Error updating document $error'));

      initJadwal();
      Constant.snack('Congratulations!', 'Reminder created successfully', true);
      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(Routes.HOME);
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  @override
  void onInit() {
    super.onInit();
    namaObatC = TextEditingController();
    dosisObatC = TextEditingController();
    initJadwal();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    namaObatC.dispose();
    dosisObatC.dispose();
    super.onClose();
  }

  pickerDateTime(BuildContext context, CupertinoDatePickerMode mode) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        color: Colors.white,
        height: 250,
        width: Get.width,
        child: CupertinoDatePicker(
          backgroundColor: Colors.white,
          initialDateTime: pickerTime,
          onDateTimeChanged: (value) {
            if (mode == CupertinoDatePickerMode.time) {
              pickerTime = value;
            } else {
              pickerDate = value;
            }
          },
          use24hFormat: true,
          mode: mode,
        ),
      ),
    );
  }

  setLocalNotification(String namaObat, String dosisObat, Status statusMinum) {
    if (namaObat.isEmpty || namaObat == '') {
      Constant.snack('Oh Snap!', "Input nama obat", false);
      return;
    }

    if (dosisObat.isEmpty || dosisObat == '') {
      Constant.snack('Oh Snap!', "Input dosis obat", false);
      return;
    }

    int hour = int.parse(DateFormat('HH').format(pickerTime));
    int minute = int.parse(DateFormat('m').format(pickerTime));

    int day = int.parse(DateFormat('d').format(pickerDate));
    int month = int.parse(DateFormat('MM').format(pickerDate));
    int year = int.parse(DateFormat('yyyy').format(pickerDate));

    print("${hour}:${minute}");
    print("$day/$month/$year");

    String waktu = "${hour}:${minute}";
    String tanggal = "$day/$month/$year";

    addJadwalMinumObat(namaObat, dosisObat, statusMinum, waktu, tanggal);

    NotificationController().scheduleNotification(
      title: 'Si remi',
      body: 'Jangan lupa minum obat mu ya! ^^',
      reminder: TimeOfDay(hour: hour, minute: minute),
      day: day,
      month: month,
      year: year,
    );
  }
}
