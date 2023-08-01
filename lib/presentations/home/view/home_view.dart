import 'package:cached_network_image/cached_network_image.dart';
import 'package:chairil/core/app/color_palette.dart';
import 'package:chairil/presentations/component/component.dart';
import 'package:chairil/presentations/component/shimmer.dart';
import 'package:chairil/presentations/home/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'user_detail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Component.appbar("User"),
      backgroundColor: ColorPalette.white,
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          if (controller.isloading) {
            return ShimmerListuser();
          } else {
            return SmartRefresher(
              enablePullUp: true,
              enablePullDown: false,
              controller: controller.refreshController,
              onLoading: () => controller.getuserMore(),
              footer: footer(),
              child: ListView.builder(
                itemCount: controller.listUser.length,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => Get.to(
                      UserDetailView(
                        id: controller.listUser[index].id ?? "",
                      ),
                      transition: Transition.fade,
                    ),
                    child: Container(
                      decoration: Component.shadowContainer(),
                      margin: EdgeInsets.only(top: 5, bottom: (controller.listUser.length - 1) == index ? 50 : 5),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: controller.listUser[index].picture ?? "",
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                              placeholder: (context, url) => CupertinoActivityIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Component.text("${controller.listUser[index].title} ${controller.listUser[index].firstName}",
                                  colors: ColorPalette.blackText, fontSize: 14),
                              // const SizedBox(
                              //   height: ,
                              // ),
                              Component.text(
                                controller.listUser[index].lastName ?? "",
                                colors: ColorPalette.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  static Widget footer() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? loadStatus) {
        Widget footer;
        switch (loadStatus) {
          case LoadStatus.idle:
          case LoadStatus.loading:
            footer = ShimmerListuser();
            break;
          case LoadStatus.failed:
            footer = const Text("Gagal untuk memuat data!");
            break;
          case LoadStatus.canLoading:
            footer = const Text("Lepas untuk memuat data");
            break;
          default:
            footer = const Text("Akhir Data");
            break;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Center(child: footer),
        );
      },
    );
  }
}
