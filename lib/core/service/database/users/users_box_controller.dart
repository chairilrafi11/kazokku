import 'package:chairil/core/core_function.dart';
import 'package:chairil/core/service/database/app_box.dart';

import '../app_database.dart';
import 'users_box.dart';

class UsersBoxController {
  static Future save(UsersBox usersBox, {bool clear = false}) async {
    await AppDatabase.openBoxDatabase(AppBox.usersName).then((box) async {
      if (clear) await box.clear();
      await box.add(usersBox);
    });
  }

  static Future<List<UsersBox>> load() async {
    List<UsersBox> list = [];
    await AppDatabase.openBoxDatabase(AppBox.usersName).then((box) {
      CoreFunction.logPrint("Users Box", box.values.toString());
      if (box.isNotEmpty) {
        for (var item in box.values) {
          list.add(item);
        }
      }
    });
    return list;
  }

  static Future clear() async {
    await AppDatabase.openBoxDatabase(AppBox.usersName).then((box) async {
      await box.clear();
    });
  }
}
