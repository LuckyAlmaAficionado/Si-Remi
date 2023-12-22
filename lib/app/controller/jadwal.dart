import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:simedi/app/models/akun.dart';

import '../models/jadwal.dart';

class JadwalController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  var listJadwal = <Jadwal>[].obs;
  var docId = ''.obs;

  initJadwal() async {
    listJadwal.clear();
    Akun? listAkun;

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('account')
          .where('uid', isEqualTo: auth.currentUser!.uid)
          .get();

      List<Map<String, dynamic>> data =
          querySnapshot.docs.map((e) => e.data()).toList();

      data.forEach((element) {
        listAkun = Akun.fromJson(element);
      });

      if (listAkun!.jadwal!.isNotEmpty) {
        print('ada jadwal ${listAkun!.jadwal}');
        listJadwal.value = listAkun!.jadwal!;
      }

      docId.value = listAkun!.docId;
      print('tidak ada jadwal');
    } on FirebaseException catch (e) {
      throw e;
    }
  }
}
