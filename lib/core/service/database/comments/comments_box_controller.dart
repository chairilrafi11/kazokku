import 'package:chairil/core/core_function.dart';
import 'package:chairil/core/service/database/app_box.dart';

import '../app_database.dart';
import 'comments_box.dart';

class CommentsBoxController {
  static Future save(CommentsBox commentsBox, {bool clear = false}) async {
    await AppDatabase.openBoxDatabase(AppBox.commentsName).then((box) async {
      if (clear) await box.clear();
      await box.add(commentsBox);
    });
  }

  static Future<List<CommentsBox>> load() async {
    List<CommentsBox> list = [];
    await AppDatabase.openBoxDatabase(AppBox.commentsName).then((box) {
      CoreFunction.logPrint("Comments Box", box.values.toString());
      if (box.isNotEmpty) {
        for (var item in box.values) {
          list.add(item);
        }
      }
    });
    return list;
  }

  static Future clear() async {
    await AppDatabase.openBoxDatabase(AppBox.commentsName).then((box) async {
      await box.clear();
    });
  }
}
