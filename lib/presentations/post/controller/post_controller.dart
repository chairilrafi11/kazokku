import 'package:chairil/domain/models/post.dart';
import 'package:chairil/domain/repository/post_repository.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostController extends GetxController {
  int page = 1;
  bool isLoading = true;
  String tag = "";
  List<Post> listPost = [];
  Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;
  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    onGetPost();
    super.onInit();
  }

  onGetPost() async {
    isLoading = true;
    update();
    listPost.addAll(await PostRepository.list(page));
    isLoading = false;
    update();
  }

  onGetPostMore() async {
    page += 1;
    refreshController.footerMode!.value = LoadStatus.canLoading;
    update();
    refreshController.loadComplete();
    if (tag != "") {
      listPost.addAll(await PostRepository.listWithTag(tag, page));
    } else {
      listPost.addAll(await PostRepository.list(page));
    }
    refreshController.refreshCompleted();
    update();
  }

  addTag(String postTag) async {
    isLoading = true;
    // update();
    tag = postTag;
    page = 1;
    listPost = await PostRepository.listWithTag(postTag, page);
    isLoading = false;
    update();
  }

  removeTag() {
    tag = "";
    onGetPost();
  }
}
