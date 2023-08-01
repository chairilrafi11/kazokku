import 'package:cached_network_image/cached_network_image.dart';
import 'package:chairil/core/app/color_palette.dart';
import 'package:chairil/core/util/size_config.dart';
import 'package:chairil/presentations/component/shimmer.dart';
import 'package:chairil/presentations/home/controller/user_detail_controller.dart';
import 'package:chairil/presentations/widgets/post_widget.dart';
import 'package:chairil/presentations/component/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserDetailView extends StatelessWidget {
  final String id;

  const UserDetailView({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Component.appbar("title"),
      backgroundColor: ColorPalette.whiteBackground,
      body: GetBuilder<UserDetailController>(
        init: UserDetailController(id: id),
        builder: (controller) {
          if (controller.isLoading) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ShimmerUserDetail(),
            );
          } else {
            return SmartRefresher(
              controller: controller.refreshController,
              enablePullUp: true,
              enablePullDown: false,
              onLoading: () => controller.onGetPostMore(),
              footer: footer(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: Component.shadowContainer(),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    imageUrl: controller.userDetail.picture ?? "",
                                    fit: BoxFit.cover,
                                    width: SizeConfig.blockSizeHorizontal * 20,
                                    height: SizeConfig.blockSizeHorizontal * 20,
                                    placeholder: (context, url) => CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Component.text(
                                        "${controller.userDetail.title} ${controller.userDetail.firstName} ${controller.userDetail.lastName}",
                                        fontWeight: FontWeight.bold,
                                        colors: ColorPalette.blue,
                                        fontSize: 14,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Component.text(
                                              "Gender :",
                                              colors: ColorPalette.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Component.text(
                                              controller.userDetail.gender ?? "",
                                              fontSize: 10,
                                              colors: ColorPalette.blackText,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Component.text(
                                              "Date of birth :",
                                              colors: ColorPalette.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Component.text(
                                              DateFormat("yyyy-MM-dd").format(
                                                DateTime.parse(
                                                  controller.userDetail.dateOfBirth ?? DateTime.now().toString(),
                                                ),
                                              ),
                                              fontSize: 10,
                                              colors: ColorPalette.blackText,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Component.text(
                                              "Join from :",
                                              fontSize: 10,
                                              colors: ColorPalette.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Component.text(
                                              DateFormat("yyyy-MM-dd").format(DateTime.parse(controller.userDetail.registerDate ?? "")),
                                              fontSize: 10,
                                              colors: ColorPalette.blackText,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Component.text(
                                              "Email :",
                                              colors: ColorPalette.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Component.text(
                                              controller.userDetail.email ?? "",
                                              fontSize: 10,
                                              colors: ColorPalette.blackText,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Flexible(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Component.text(
                                                "Address :",
                                                fontSize: 10,
                                                colors: ColorPalette.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              flex: 3,
                                              child: Component.text(
                                                "${controller.userDetail.location?.street} ${controller.userDetail.location?.city} ${controller.userDetail.location?.state} ${controller.userDetail.location?.country}",
                                                fontSize: 10,
                                                maxLines: 5,
                                                colors: ColorPalette.blackText,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            (() {
                              if (controller.loadingFollow) {
                                return CupertinoActivityIndicator();
                              } else {
                                return InkWell(
                                  onTap: () => controller.onClick(),
                                  child: Card(
                                    color: controller.following ? ColorPalette.green : ColorPalette.blue,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            controller.following ? Icons.check : Icons.person_add,
                                            color: ColorPalette.white,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Component.text(controller.following ? "Following" : "Follow",
                                              colors: ColorPalette.white, fontWeight: FontWeight.bold, fontSize: 14)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }())
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Component.divider(),
                      const SizedBox(
                        height: 5,
                      ),
                      PostWidgets(
                        canScroll: false,
                        listPost: controller.listPost,
                      )
                    ],
                  ),
                ),
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
            footer = ShimmerListPost();
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
