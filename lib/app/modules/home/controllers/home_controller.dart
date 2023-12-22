import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simedi/app/constant/constant.dart';
import 'package:simedi/app/routes/app_pages.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  late TextEditingController searchC;
  var name = ''.obs;

  initAccount() {
    name.value =
        modifyString(_auth.currentUser!.displayName!.split(' ').first, 0);
  }

  String modifyString(String input, int index) {
    // Pastikan index berada dalam rentang string
    if (index < 0 || index >= input.length) {
      return input;
    }

    // Ambil karakter pada indeks yang ditentukan
    String firstPart = input.substring(0, index);
    String changedChar = input[index].toUpperCase();
    String secondPart = input.substring(index + 1);

    // Gabungkan kembali string yang sudah dimodifikasi
    String modifiedString = firstPart + changedChar + secondPart;

    return modifiedString;
  }

  infoJadwalMinumObat() {
    Constant.snackbar(
        'Jadwal Minum Obat',
        'Informasi dibawah adalah jadwal minum obat anda jangan sampai lupa',
        true);
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  logout() async {
    await _auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    searchC = TextEditingController();
    initAccount();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
