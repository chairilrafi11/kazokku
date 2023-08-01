import 'package:chairil/core/service/database/users/users_box.dart';
import 'package:chairil/core/service/database/users/users_box_controller.dart';
import 'package:chairil/domain/models/post.dart';
import 'package:chairil/domain/models/user_detail.dart';
import 'package:chairil/domain/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserDetailController extends GetxController {
  String id;

  UserDetailController({required this.id});

  int page = 1;
  bool isLoading = true;
  bool following = false;
  bool loadingFollow = true;
  late UserDetail userDetail;
  List<Post> listPost = [];
  RefreshController refreshController = RefreshController();

  @override
  void onInit() {
    onGetDetail();
    onGetPost();
    super.onInit();
  }

  onGetDetail() async {
    userDetail = await UserRepository.detail(id);
    isLoading = false;
    var listFollow = await UsersBoxController.load();
    var index = listFollow.indexWhere((element) => element.id == id);
    if (index != -1) {
      following = true;
    }
    loadingFollow = false;
    update();
  }

  onGetPost() async {
    listPost.addAll(await UserRepository.post(id));
    refreshController.footerMode!.value = LoadStatus.canLoading;
    refreshController.refreshCompleted();
    update();
  }

  onGetPostMore() async {
    refreshController.footerMode!.value = LoadStatus.canLoading;
    update();
    refreshController.loadComplete();

    refreshController.refreshCompleted();
    page += 1;
    listPost.addAll(await UserRepository.post(id, page: page));
    update();
  }

  onClick() async {
    loadingFollow = true;
    update();
    var list = await UsersBoxController.load();
    if (following) {
      list.removeWhere((element) => element.id == id);
      //? unfollow
      following = false;
    } else {
      //? follow
      await UsersBoxController.save(UsersBox(id: id));
      following = true;
    }
    loadingFollow = false;
    update();
  }
}
