import 'package:chairil/core/app/app_config.dart';
import 'package:chairil/core/app/color_palette.dart';
import 'package:chairil/core/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListuser extends StatelessWidget {
  const ShimmerListuser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // getting the size of the window
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Shimmer.fromColors(
      period: const Duration(milliseconds: AppConfig.durationShimmer),
      highlightColor: ColorPalette.white,
      baseColor: ColorPalette.grey200,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext builder, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 70,
            width: width,
            color: ColorPalette.grey200,
          );
        },
      ),
    );
  }
}

class ShimmerListPost extends StatelessWidget {
  const ShimmerListPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // getting the size of the window
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Shimmer.fromColors(
      period: const Duration(milliseconds: AppConfig.durationShimmer),
      highlightColor: ColorPalette.white,
      baseColor: ColorPalette.grey200,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext builder, int index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.grey200,
                    ),
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        height: 10,
                        width: width * 0.5,
                        color: ColorPalette.grey200,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        height: 10,
                        width: width * 0.1,
                        color: ColorPalette.grey200,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 200,
                width: width,
                color: ColorPalette.grey200,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 20,
                width: width,
                color: ColorPalette.grey200,
              ),
            ],
          );
        },
      ),
    );
  }
}

class ShimmerUserDetail extends StatelessWidget {
  const ShimmerUserDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // getting the size of the window
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Shimmer.fromColors(
      period: const Duration(milliseconds: AppConfig.durationShimmer),
      highlightColor: ColorPalette.white,
      baseColor: ColorPalette.grey200,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorPalette.grey200,
            ),
            height: SizeConfig.blockSizeHorizontal * 20,
            width: SizeConfig.blockSizeHorizontal * 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 15,
                width: width * 0.5,
                color: ColorPalette.grey200,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 15,
                width: width * 0.4,
                color: ColorPalette.grey200,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 15,
                width: width * 0.6,
                color: ColorPalette.grey200,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 15,
                width: width * 0.5,
                color: ColorPalette.grey200,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 15,
                width: width * 0.6,
                color: ColorPalette.grey200,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
