import 'package:chairil/core/app/color_palette.dart';
import 'package:chairil/presentations/component/shimmer.dart';
import 'package:chairil/presentations/like/controller/like_controller.dart';
import 'package:chairil/presentations/widgets/post_widget.dart';
import 'package:chairil/presentations/component/component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikeView extends StatelessWidget {
  const LikeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Component.appbar("Like"),
      backgroundColor: ColorPalette.whiteBackground,
      body: GetBuilder<LikeController>(
        init: LikeController(),
        builder: (controller) {
          if (controller.isLoading) {
            return ShimmerListPost();
          } else {
            return PostWidgets(
              canScroll: true,
              listPost: controller.listPost,
            );
          }
        },
      ),
    );
  }
}
