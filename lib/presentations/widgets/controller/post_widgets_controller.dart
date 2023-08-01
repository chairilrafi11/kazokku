import 'package:chairil/core/service/database/posts/posts_box.dart';
import 'package:chairil/core/service/database/posts/posts_box_controller.dart';
import 'package:chairil/domain/models/post.dart';
import 'package:chairil/domain/repository/post_repository.dart';
import 'package:get/get.dart';

class PostWidgetsController extends GetxController {
  List<String> listLikes = [];

  @override
  void onInit() {
    onFetchData();
    super.onInit();
  }

  onFetchData() async {
    var listPost = await PostsBoxController.load();
    listPost.forEach((element) {
      listLikes.add(element.id ?? "");
    });
    update();
  }

  onClickLike(Post post) async {
    if (listLikes.contains(post.id)) {
      listLikes.remove(post.id);

      update();
      var listPost = await PostsBoxController.load();
      listPost.removeWhere((element) => element.id == post.id);
      await PostsBoxController.saveAll(listPost);
    } else {
      listLikes.add(post.id!);
      update();
      await PostsBoxController.save(PostsBox.fromJson(post.toJson()));
    }
  }

  Future onGetComment(String id) async {
    return await PostRepository.comnents(id);
  }
}
