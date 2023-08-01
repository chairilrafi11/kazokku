import 'dart:io';

import 'package:chairil/core/app/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CoreFunction {
  static String moneyFormatter(dynamic value) {
    double price = double.tryParse(value.toString()) ?? 0;
    var idr = NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: "Rp");
    return idr.format(price);
  }

  static String getEnv(String val) => dotenv.env[val] ?? "";

  static void logPrint(String? key, dynamic value) {
    print("$key => ${value.toString()}");
  }

  static Future<bool> checkConnectivity() async {
    bool connect = false;
    try {
      final result = await InternetAddress.lookup('google.com').timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connect = true;
      }
    } on SocketException catch (_) {
      connect = false;
    }
    debugPrint("Check Connection $connect");
    return connect;
  }

  static void toast(String title, String message, {Color backgroundColor = ColorPalette.red, IconData? icons}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      icon: Icon(
        Icons.info,
        color: ColorPalette.white,
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
