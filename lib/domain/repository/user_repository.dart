import 'package:chairil/core/service/dio/dio_service.dart';
import 'package:chairil/domain/models/post.dart';
import 'package:chairil/domain/models/user.dart';
import 'package:chairil/domain/models/user_detail.dart';

class UserRepository {
  static Future<List<User>> list({int? page}) async {
    List<User> list = [];
    var response = await DioService.dioClient.userList(page: page);
    response.data?.forEach((element) {
      list.add(User.fromJson(element));
    });
    return list;
  }

  static Future<UserDetail> detail(String id) async {
    return await DioService.dioClient.userDetail(id);
  }

  static Future<List<Post>> post(String id, {int? page}) async {
    List<Post> list = [];
    var response = await DioService.dioClient.userPost(id, limit: 20, page: page);
    response.data?.forEach((element) {
      list.add(Post.fromJson(element));
    });
    return list;
  }
}
