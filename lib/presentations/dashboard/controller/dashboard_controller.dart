import 'package:chairil/core/core_function.dart';
import 'package:get/get.dart';

enum DashboardType { Home, Post, Like }

class DashboardController extends GetxController {
  DateTime? backButtonPressTime;
  final snackBarDuration = const Duration(seconds: 3);
  DashboardType dashboardType = DashboardType.Home;

  onChangeDashboard(int value) {
    switch (value) {
      case 0:
        dashboardType = DashboardType.Home;
        break;
      case 1:
        dashboardType = DashboardType.Post;
        break;
      case 2:
        dashboardType = DashboardType.Like;
        break;
    }
    update();
  }

  Future<bool> handleWillPop() async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed = backButtonPressTime == null || now.difference(backButtonPressTime!) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      CoreFunction.toast("Konfirmasi", "Tekan sekali lagi untuk keluar");
      return false;
    }
    return true;
  }
}
