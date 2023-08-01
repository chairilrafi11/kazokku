import 'package:chairil/core/app/color_palette.dart';
import 'package:chairil/core/util/size_config.dart';
import 'package:chairil/presentations/post/view/post_view.dart';
import 'package:chairil/presentations/dashboard/controller/dashboard_controller.dart';
import 'package:chairil/presentations/home/view/home_view.dart';
import 'package:chairil/presentations/like/view/like_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key, this.page = 0}) : super(key: key);
  final int page;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: WillPopScope(
                onWillPop: () => controller.handleWillPop(),
                child: (() {
                  switch (controller.dashboardType) {
                    case DashboardType.Home:
                      return HomeView();
                    case DashboardType.Post:
                      return PostView();
                    case DashboardType.Like:
                      return LikeView();
                    default:
                      return Container();
                  }
                }())),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: ColorPalette.white,
              unselectedFontSize: 12,
              selectedFontSize: 12,
              currentIndex: controller.dashboardType.index,
              selectedItemColor: ColorPalette.primary,
              onTap: (index) => controller.onChangeDashboard(index),
              items: [
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.person,
                    color: ColorPalette.primary,
                  ),
                  icon: Icon(Icons.home, color: ColorPalette.grey),
                  label: "User",
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.chat,
                    color: ColorPalette.primary,
                  ),
                  icon: Icon(Icons.chat, color: ColorPalette.grey),
                  label: "Post",
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.favorite,
                    color: ColorPalette.primary,
                  ),
                  icon: Icon(Icons.favorite, color: ColorPalette.grey),
                  label: "Like",
                ),
              ],
            ),
          );
        });
  }
}
