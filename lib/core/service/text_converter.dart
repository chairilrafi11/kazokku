import 'package:chairil/core/constant.dart';

class TextConverter {
  static tagName(PostTag postTag) {
    switch (postTag) {
      case PostTag.Views:
        return "views";
      case PostTag.Dark:
        return "dark";
      case PostTag.Sky:
        return "sky";
    }
  }
}
