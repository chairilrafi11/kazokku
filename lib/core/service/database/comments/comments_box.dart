import 'package:chairil/core/service/database/app_box.dart';
import 'package:hive/hive.dart';

part 'comments_box.g.dart';

@HiveType(typeId: AppBox.comments)
class CommentsBox {
  @HiveField(1)
  int? id;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? text;
}
