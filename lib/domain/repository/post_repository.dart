import 'package:chairil/core/service/dio/dio_service.dart';
import 'package:chairil/domain/models/comment.dart';
import 'package:chairil/domain/models/post.dart';

class PostRepository {
  static Future<List<Post>> list(int page) async {
    List<Post> list = [];
    var response = await DioService.dioClient.postList(page: page, limit: 20);
    response.data?.forEach((element) {
      list.add(Post.fromJson(element));
    });
    return list;
  }

  static Future<List<Post>> listWithTag(String tag, int page) async {
    List<Post> list = [];
    var response = await DioService.dioClient.postList(page: page, limit: 20);
    response.data?.forEach((element) {
      list.add(Post.fromJson(element));
    });
    return list;
  }

  static Future<List<Comments>> comnents(String id) async {
    List<Comments> list = [];
    var response = await DioService.dioClient.postComments(id, limit: 20);
    response.data?.forEach((element) {
      list.add(Comments.fromJson(element));
    });
    return list;
  }
}
