import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Color.fromARGB(255, 86, 163, 243);
Color primaryContainerColor = Color.fromARGB(255, 225, 243, 253);
Color secondary = Color(0xFF6877C7);

class Constant extends GetxController {
  static snackbar(String title, String text, bool isSuccess) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: (isSuccess) ? Colors.green.shade400 : Colors.red,
      title: title,
      titleStyle: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.outfit(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
    );
  }

  static snack(String title, String message, bool isSuccess) {
    Get.snackbar(
      'title',
      'message',
      backgroundColor: (isSuccess) ? Colors.green.shade400 : Colors.red,
      titleText: Text(
        title,
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      messageText: Text(
        message,
        style: GoogleFonts.outfit(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
