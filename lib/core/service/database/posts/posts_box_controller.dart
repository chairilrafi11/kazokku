import 'package:chairil/core/core_function.dart';
import 'package:chairil/core/service/database/app_box.dart';

import '../app_database.dart';
import 'posts_box.dart';

class PostsBoxController {
  static Future save(PostsBox postsBox, {bool clear = false}) async {
    await AppDatabase.openBoxDatabase(AppBox.postsName).then((box) async {
      if (clear) await box.clear();
      await box.add(postsBox);
    });
  }

  static Future saveAll(List<PostsBox> postsBox, {bool clear = false}) async {
    await AppDatabase.openBoxDatabase(AppBox.postsName).then((box) async {
      if (clear) await box.clear();
      await box.addAll(postsBox);
    });
  }

  static Future<List<PostsBox>> load() async {
    List<PostsBox> list = [];
    await AppDatabase.openBoxDatabase(AppBox.postsName).then((box) {
      CoreFunction.logPrint("Posts Box", box.values.toString());
      if (box.isNotEmpty) {
        for (var item in box.values) {
          list.add(item);
        }
      }
    });
    return list;
  }

  static Future clear() async {
    await AppDatabase.openBoxDatabase(AppBox.postsName).then((box) async {
      await box.clear();
    });
  }
}
