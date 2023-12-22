import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simedi/app/controller/nofitication.dart';
import 'package:simedi/app/routes/app_pages.dart';

import '../../../constant/constant.dart';

class LoginController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passwordC;

  var isShowPass = true.obs;

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

  validatePassword(String password) {
    if (password == '' || password.isEmpty) {
      Constant.snackbar('Oh Snap!', 'Password masih kosong', false);
      return false;
    } else if (password.length < 6) {
      Constant.snackbar('Oh Snap!', 'Panjang password kurang', false);
      return false;
    }
    return true;
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  login(String email, String password) async {
    if (!validateEmail(email)) return;
    if (!validatePassword(password)) return;

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Constant.snackbar('Oh Snap!', 'No user found for that email', false);
      } else if (e.code == 'wrong-password') {
        Constant.snackbar(
            'Oh Snap!', 'Wrong password provided for that user', false);
      }
      throw e;
    }
  }

  @override
  void onInit() {
    super.onInit();
    emailC = TextEditingController();
    passwordC = TextEditingController();

    NotificationController.initPerminssionHandler();
    NotificationController.initNofitication();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}
