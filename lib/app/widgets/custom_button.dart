import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simedi/app/constant/constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
