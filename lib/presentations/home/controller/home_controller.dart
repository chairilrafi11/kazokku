import 'package:chairil/domain/models/user.dart';
import 'package:chairil/domain/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  List<User> listUser = [];
  bool isloading = true;
  RefreshController refreshController = RefreshController();
  int page = 1;

  @override
  void onInit() {
    getuser();
    super.onInit();
  }

  Future getuser() async {
    listUser.addAll(await UserRepository.list());
    isloading = false;
    refreshController.footerMode!.value = LoadStatus.canLoading;
    refreshController.refreshCompleted();
    update();
  }

  Future getuserMore() async {
    refreshController.footerMode!.value = LoadStatus.loading;
    update();
    refreshController.loadComplete();

    refreshController.refreshCompleted();
    page += 1;
    listUser.addAll(await UserRepository.list(page: page));
    update();
  }
}
