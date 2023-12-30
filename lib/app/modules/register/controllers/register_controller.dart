import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simedi/app/models/akun.dart';
import 'package:simedi/app/routes/app_pages.dart';

import '../../../constant/constant.dart';

class RegisterController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController emailC;
  late TextEditingController passC;
  late TextEditingController confPassC;

  var isShowPass = true.obs;
  var isShowConfPass = true.obs;

  validateEmail(String email) {
    if (email.isEmpty || email == '') {
      Constant.snackbar('Oh Snap!', 'Email masih kosong', false);
      return false;
    } else if (!email.isEmail) {
      Constant.snackbar('Oh Snap!', 'Format email salah', false);
      return false;
    }
    return true;
  }

  validatePassword(String password, String confPass) {
    if (password == '' || password.isEmpty) {
      Constant.snackbar('Oh Snap!', 'Password masih kosong', false);
      return false;
    } else if (password.length < 6) {
      Constant.snackbar('Oh Snap!', 'Panjang password kurang', false);
      return false;
    } else if (confPass.length < 6) {
      Constant.snackbar('Oh Snap!', 'Panjang confirm password kurang', false);
      return false;
    } else if (confPass.isEmpty || confPass == '') {
      Constant.snackbar('Oh Snap!', 'Confirm password masih kosong', false);
      return false;
    } else if (!confPass.contains(password) || !password.contains(confPass)) {
      Constant.snackbar(
          'Oh Snap!', 'Password dan confirm password tidak sama', false);
      return false;
    }
    return true;
  }

  registerAccount(
      String nama, String email, String password, String confirmPassword) {
    print(nama);
    print(email);
    print(password);
    print(confirmPassword);

    if (!validateEmail(email)) {
      return;
    } else if (!validatePassword(password, confirmPassword)) {
      return;
    } else {
      createNewAccountFirestoreDatabase(nama, email, password, confirmPassword);
    }
  }

  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  createNewAccountFirestoreDatabase(
    String nama,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      CollectionReference reference = _db.collection('account');

      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = credential.user;
      await user?.updateEmail(email);
      await user?.updateDisplayName(nama);

      final docId = reference.doc().id;

      Akun akun = Akun(
        uid: _auth.currentUser!.uid,
        docId: docId,
        nama: nama,
        email: email,
        role: 'pasien',
      );

      print('create account');

      await reference.doc(docId).set(akun.toJson()).onError(
            (error, stackTrace) => print('Error writing document: $error'),
          );
      Get.back();
      Constant.snack('Congratulations!', 'Successfully create account', true);
      await Future.delayed(const Duration(seconds: 2));
      Get.toNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      print("code register: ${e.code}");

      String arg = e.code;
      if (arg == "email-already-in-use") {
        Constant.snack('Oh Snap!', 'Email already in user', false);
      } else {}
      print("code register: ${e.code}");
      throw e;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    nameC = TextEditingController();
    emailC = TextEditingController();
    passC = TextEditingController();
    confPassC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameC.dispose();
    emailC.dispose();
    passC.dispose();
    confPassC.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
