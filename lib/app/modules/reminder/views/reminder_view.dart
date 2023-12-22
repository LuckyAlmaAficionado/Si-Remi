import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simedi/app/widgets/custom_button.dart';
import 'package:simedi/app/widgets/custom_textfield.dart';

import '../controllers/reminder_controller.dart';

class ReminderView extends GetView<ReminderController> {
  const ReminderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavBarSetReminder(),
              const Gap(20),
              CustomTextField(
                title: 'Nama obat',
                controller: controller.namaObatC,
                textInputType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                icons: false,
              ),
              const Gap(20),
              CustomTextField(
                title: 'Dosis obat',
                controller: controller.dosisObatC,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                icons: false,
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Status Minum Obat',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Gap(5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Sebelum makan',
                          style: GoogleFonts.outfit(),
                        ),
                        trailing: Radio<Status>(
                          value: Status.Sebelum,
                          groupValue: controller.statusMinumObat.value,
                          onChanged: (value) {
                            controller.statusMinumObat.value = value!;
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Sesudah makan',
                          style: GoogleFonts.outfit(),
                        ),
                        trailing: Radio<Status>(
                          value: Status.Sesudah,
                          groupValue: controller.statusMinumObat.value,
                          onChanged: (value) {
                            controller.statusMinumObat.value = value!;
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Ketika makan',
                          style: GoogleFonts.outfit(),
                        ),
                        trailing: Radio<Status>(
                          value: Status.Ketika,
                          groupValue: controller.statusMinumObat.value,
                          onChanged: (value) {
                            controller.statusMinumObat.value = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              CustomButton(
                text: 'Waktu Minum Obat',
                onTap: () => controller.pickerDateTime(
                  context,
                  CupertinoDatePickerMode.time,
                ),
              ),
              const Gap(20),
              CustomButton(
                text: 'Tanggal Minum Obat',
                onTap: () => controller.pickerDateTime(
                  context,
                  CupertinoDatePickerMode.date,
                ),
              ),
              const Gap(80),
              CustomButton(
                text: 'SIMPAN',
                onTap: () => controller.setLocalNotification(
                  controller.namaObatC.text,
                  controller.dosisObatC.text,
                  controller.statusMinumObat.value,
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarSetReminder extends StatelessWidget {
  const NavBarSetReminder({
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
                  'Tambah Jadwal',
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
