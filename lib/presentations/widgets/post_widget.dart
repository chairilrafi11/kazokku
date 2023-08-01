import 'package:cached_network_image/cached_network_image.dart';
import 'package:chairil/core/app/color_palette.dart';
import 'package:chairil/core/util/size_config.dart';
import 'package:chairil/domain/models/comment.dart';
import 'package:chairil/domain/models/post.dart';
import 'package:chairil/presentations/component/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controller/post_widgets_controller.dart';

class PostWidgets extends StatelessWidget {
  bool canScroll = false;
  List<Post> listPost;
  void Function(String postTag)? onClickTag;

  PostWidgets({required this.canScroll, required this.listPost, this.onClickTag, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostWidgetsController>(
      init: PostWidgetsController(),
      builder: (controller) {
        return ListView.builder(
          itemCount: listPost.length,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: canScroll ? 10 : 0),
          physics: canScroll ? null : const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: Component.shadowContainer(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: listPost[index].owner?.picture ?? "",
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                          placeholder: (context, url) => CupertinoActivityIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Component.text(
                            "${listPost[index].owner?.title} ${listPost[index].owner?.firstName} ${listPost[index].owner?.lastName}",
                            colors: ColorPalette.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          // const SizedBox(
                          //   height: 4,
                          // ),
                          Component.text(
                            DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.parse(listPost[index].publishDate ?? "")),
                            fontSize: 10,
                            fontWeight: FontWeight.w100,
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      imageUrl: listPost[index].image ?? "",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                      placeholder: (context, url) => CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 28,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: listPost[index].tags?.length,
                      itemBuilder: (BuildContext context, int indexTag) {
                        return InkWell(
                          onTap: () {
                            if (onClickTag != null) {
                              onClickTag!(listPost[index].tags?[indexTag] ?? "");
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(color: ColorPalette.blue, borderRadius: BorderRadius.circular(20)),
                            child: Component.text(listPost[index].tags?[indexTag] ?? "", colors: ColorPalette.white, fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Component.text(
                    listPost[index].text ?? "",
                    fontSize: 12,
                    colors: ColorPalette.blackText,
                    maxLines: 5,
                  ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // Component.text(
                  //   listPost[index].,
                  //   colors: ColorPalette.blue,
                  //   fontSize: 12,
                  //   textAlign: TextAlign.start,
                  // ),
                  Component.text("${listPost[index].likes} Likes", colors: ColorPalette.red, fontSize: 12),
                  const SizedBox(
                    height: 5,
                  ),
                  Component.divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => controller.onClickLike(listPost[index]),
                        child: controller.listLikes.contains(listPost[index].id)
                            ? Icon(
                                Icons.favorite,
                                color: ColorPalette.red,
                                size: 20,
                              )
                            : Icon(
                                Icons.favorite_outline,
                                color: ColorPalette.blackText,
                                size: 20,
                              ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Component.text("Like", colors: ColorPalette.blackText, fontSize: 12),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () async => bottomsheetComments(await controller.onGetComment(listPost[index].id ?? "")),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              color: ColorPalette.blackText,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Component.text("Comments", colors: ColorPalette.blackText, fontSize: 12),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  bottomsheetComments(List<Comments> list) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        context: Get.context!,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (BuildContext contextBottomsheet) {
          return Container(
            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 40),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: const BoxDecoration(
                color: ColorPalette.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Component.text("Comments", colors: ColorPalette.blackText, fontSize: 14, fontWeight: FontWeight.bold),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(Get.context!).pop(),
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl: list[index].owner?.picture ?? "",
                                  fit: BoxFit.cover,
                                  width: 25,
                                  height: 25,
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
                                    Flexible(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Component.text(
                                            "${list[index].owner?.title} ${list[index].owner?.firstName} ${list[index].owner?.lastName}",
                                            colors: ColorPalette.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          const Spacer(),
                                          Component.text(
                                            DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.parse(list[index].publishDate ?? "")),
                                            colors: ColorPalette.greyText,
                                            fontWeight: FontWeight.w100,
                                            fontSize: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Component.text(
                                      list[index].message ?? "",
                                      colors: ColorPalette.blackText,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 10,
                                      maxLines: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
