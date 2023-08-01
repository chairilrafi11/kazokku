import 'package:chairil/domain/models/post.dart';

class Comments {
  String? id;
  String? message;
  Owner? owner;
  String? post;
  String? publishDate;

  Comments({this.id, this.message, this.owner, this.post, this.publishDate});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    post = json['post'];
    publishDate = json['publishDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['post'] = this.post;
    data['publishDate'] = this.publishDate;
    return data;
  }
}
