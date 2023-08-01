import 'package:chairil/core/app/color_palette.dart';
import 'package:chairil/core/service/text_converter.dart';
import 'package:chairil/presentations/component/shimmer.dart';
import 'package:chairil/presentations/widgets/post_widget.dart';
import 'package:chairil/presentations/component/component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controller/post_controller.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Component.appbar("Post"),
      body: GetBuilder<PostController>(
        init: PostController(),
        builder: (controller) {
          if (controller.isLoading) {
            return ShimmerListPost();
          } else {
            return SmartRefresher(
              controller: controller.refreshController,
              enablePullUp: true,
              enablePullDown: false,
              onLoading: () => controller.onGetPostMore(),
              footer: footer(),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.tag.isNotEmpty)
                      Stack(
                        // alignment: Alignment.topRight,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(color: ColorPalette.blue, borderRadius: BorderRadius.circular(20)),
                            child: Component.text(controller.tag, colors: ColorPalette.white, fontSize: 12),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () => controller.removeTag(),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorPalette.red,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: ColorPalette.white,
                                  size: 10,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    PostWidgets(
                      canScroll: false,
                      onClickTag: controller.addTag,
                      listPost: controller.listPost,
                    ),
                  ],
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
