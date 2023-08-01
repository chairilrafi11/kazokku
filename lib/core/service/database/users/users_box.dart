import 'package:chairil/core/service/database/app_box.dart';
import 'package:hive/hive.dart';

part 'users_box.g.dart';

@HiveType(typeId: AppBox.users)
class UsersBox {
  @HiveField(1)
  String? id;
  UsersBox({this.id});
}
