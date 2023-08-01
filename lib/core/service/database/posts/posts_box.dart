import 'dart:convert';

import 'package:chairil/core/service/database/app_box.dart';
import 'package:chairil/domain/models/post.dart';
import 'package:hive/hive.dart';

part 'posts_box.g.dart';

@HiveType(typeId: AppBox.posts)
class PostsBox {
  @HiveField(1)
  String? id;

  @HiveField(2)
  String? image;

  @HiveField(3)
  int? likes;
  @HiveField(4)
  String? tags;

  @HiveField(5)
  String? text;

  @HiveField(6)
  String? publishDate;

  @HiveField(7)
  String? owner;

  PostsBox({
    this.id,
    this.image,
    this.likes,
    this.tags,
    this.text,
    this.publishDate,
    this.owner,
  });

  PostsBox.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    likes = json['likes'];
    tags = jsonEncode(json['tags']);
    text = json['text'];
    publishDate = json['publishDate'];
    owner = json['owner'] != null ? jsonEncode(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['likes'] = this.likes;
    data['tags'] = this.tags;
    data['text'] = this.text;
    data['publishDate'] = this.publishDate;
    if (this.owner != null) {
      data['owner'] = jsonDecode(this.owner!);
    }
    return data;
  }
}
