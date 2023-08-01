import 'package:chairil/core/app/app_config.dart';
import 'package:chairil/core/app/color_palette.dart';
import 'package:flutter/material.dart';

class Component {
  static AppBar appbar(String title) => AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: ColorPalette.white,
        elevation: 0,
        title: Component.text(
          title,
          colors: ColorPalette.blackText,
          fontWeight: FontWeight.bold,
        ),
      );

  static Text text(String content,
      {Color colors = Colors.black54,
      double fontSize = 15,
      FontWeight fontWeight = FontWeight.normal,
      int maxLines = 2,
      TextAlign textAlign = TextAlign.start,
      String fontFamily = AppConfig.poppinsRegular}) {
    return Text(
      content,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: fontWeight,
        color: colors,
        fontFamily: fontFamily,
        fontSize: fontSize.toDouble(),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  static BoxDecoration shadowContainer() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      );

  static divider({double height = 5.0, Color color = ColorPalette.greyBorder, double thickness = 1}) => Divider(
        height: height,
        thickness: thickness,
        // indent: 20,
        // endIndent: 0,
        color: color,
      );
}
