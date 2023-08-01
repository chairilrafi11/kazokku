import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComponentDialog {
  static loading() {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Center(child: CupertinoActivityIndicator()),
        ),
      ),
    );
  }
}
