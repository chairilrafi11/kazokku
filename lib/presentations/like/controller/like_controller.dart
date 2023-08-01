import 'package:chairil/core/service/database/posts/posts_box_controller.dart';
import 'package:chairil/domain/models/post.dart';
import 'package:get/get.dart';

class LikeController extends GetxController {
  bool isLoading = true;
  List<Post> listPost = [];

  @override
  void onInit() {
    onGetData();
    super.onInit();
  }

  onGetData() async {
    var temp = await PostsBoxController.load();
    temp.forEach((element) {
      listPost.add(Post.fromJson(element.toJson()));
    });
    isLoading = false;
    update();
  }
}
