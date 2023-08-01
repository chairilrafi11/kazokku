import 'package:chairil/core/app/color_palette.dart';
import 'package:chairil/core/service/database/comments/comments_box.dart';
import 'package:chairil/core/service/database/posts/posts_box.dart';
import 'package:chairil/core/service/database/users/users_box.dart';
import 'package:chairil/core/service/dio/dio_service.dart';
import 'package:chairil/presentations/dashboard/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  initService();
  runApp(MyApp());
}

void initService() async {
  //? Load ENV
  await dotenv.load(fileName: '.env');

  //? Setup Dio
  await DioService.setupDio();

  //? Hive Storage
  await Hive.initFlutter();
  Hive.registerAdapter(CommentsBoxAdapter());
  Hive.registerAdapter(PostsBoxAdapter());
  Hive.registerAdapter(UsersBoxAdapter());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.light().copyWith(
        buttonTheme: ButtonThemeData(
          buttonColor: ColorPalette.primary,
          textTheme: ButtonTextTheme.primary,
        ),
        primaryColor: ColorPalette.primary,
        scaffoldBackgroundColor: ColorPalette.white,
        buttonColor: ColorPalette.primary,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: ColorPalette.blackText),
        canvasColor: ColorPalette.whiteBackground,
      ),
      home: Dashboard(),
    );
  }
}
