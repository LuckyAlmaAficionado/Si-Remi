import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:simedi/app/constant/constant.dart';
import 'package:simedi/app/modules/asking/models/question.dart';
import 'package:simedi/app/routes/app_pages.dart';

class AskingController extends GetxController {
  var question = <Question>[
    Question(
      id: 1,
      question:
          'Bagaimana perasaan Anda hari ini, apakah sudah mulai terasa lebih baik atau masih ada keluhan kesehatan?',
      ans_1: 'Sudah mulai merasa jauh lebih baik',
      ans_2: 'Lumayan, ada perbaikan tetapi masih ada beberapa keluhan',
      ans_3: 'Masih merasakan sakit atau tidak nyaman',
    ),
    Question(
      id: 2,
      question:
          'Apakah ada perubahan positif dalam kondisi kesehatan Anda belakangan ini?',
      ans_1: 'Ya, ada banyak perubahan positif',
      ans_2:
          'Ada beberapa perubahan positif, tapi masih ada yang perlu diperhatikan',
      ans_3: 'Tidak terlalu banyak perubahan atau masih ada perburukan',
    ),
    Question(
      id: 3,
      question:
          'Bagaimana tidur Anda, apakah sudah lebih baik atau masih mengalami kesulitan tidur?',
      ans_1: 'Sudah tidur dengan baik dan nyenyak',
      ans_2: 'Tidur cukup, tetapi masih ada kesulitan tertentu',
      ans_3: 'Masih mengalami gangguan tidur',
    ),
    Question(
      id: 4,
      question:
          'Apakah ada aktivitas atau hal tertentu yang membuat Anda merasa lebih baik atau sebaliknya?',
      ans_1: 'Aktivitas tertentu membuat saya merasa sangat baik',
      ans_2:
          'Beberapa aktivitas membantu, tetapi masih ada yang perlu diperhatikan',
      ans_3:
          'Masih sulit menemukan aktivitas yang membuat saya merasa lebih baik',
    ),
    Question(
      id: 5,
      question:
          'Bagaimana dengan energi dan semangat Anda, apakah sudah kembali pulih atau masih perlu waktu untuk pemulihan lebih lanjut?',
      ans_1: 'Energi dan semangat sudah pulih sepenuhnya',
      ans_2: 'Ada peningkatan, tetapi masih butuh waktu untuk pulih sepenuhnya',
      ans_3: 'Energi dan semangat masih rendah',
    ),
  ].obs;

  var ans_1 = 0.obs;
  var ans_2 = 0.obs;
  var ans_3 = 0.obs;

  var answeredAnswer = 0.obs;

  late CarouselController carouselController;

  inputAnswerFromUser(int answer) {
    print(answeredAnswer);
    switch (answer) {
      case 1:
        ans_1++;
        carouselController.nextPage();
        break;
      case 2:
        ans_2++;
        carouselController.nextPage();
        break;
      case 3:
        ans_3++;
        carouselController.nextPage();
        break;
      default:
        print('wrong format');
        break;
      // if (answeredAnswer == 4) {
      //   return;
      // }
    }
    if (answeredAnswer == 4) {
      conslusionAnswered(ans_1.value, ans_2.value, ans_3.value);
      return;
    }
    answeredAnswer++;
  }

  conslusionAnswered(int ans_1, int ans_2, int ans_3) async {
    if (ans_1 > ans_2 && ans_1 > ans_3) {
      Constant.snackbar(
          'Congratulations',
          'Selamat atas kesembuhan kamu jangan lupa tetap minum vitamin ya!',
          true);
    } else if (ans_2 > ans_1 && ans_2 > ans_3) {
      Constant.snackbar("Let's push a bit more for recovery!",
          'Ayoo sedikit lagi sembuh jangan lupa minum obat yaa!', true);
    } else if (ans_3 > ans_2 && ans_3 > ans_1) {
      Constant.snackbar("Get well soon, stay strong!",
          'Jangan lupa minum obat dan tetap semangat yaa!', true);
    } else {
      Constant.snackbar("Let's push a bit more for recovery!",
          'Ayoo sedikit lagi sembuh jangan lupa minum obat yaa!', true);
    }

    await Future.delayed(const Duration(seconds: 3))
        .then((value) => Get.offAllNamed(Routes.HOME));
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    carouselController = CarouselController();
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
