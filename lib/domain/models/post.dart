import 'dart:convert';

class Post {
  String? id;
  String? image;
  int? likes;
  List<String>? tags;
  String? text;
  String? publishDate;
  Owner? owner;

  Post({
    this.id,
    this.image,
    this.likes,
    this.tags,
    this.text,
    this.publishDate,
    this.owner,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    likes = json['likes'];
    if (json['tags'] is String) {
      tags = jsonDecode(json['tags']).cast<String>();
    } else {
      tags = json['tags'].cast<String>();
    }
    text = json['text'];
    publishDate = json['publishDate'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
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
      data['owner'] = this.owner!.toJson();
    }
    return data;
  }
}

class Owner {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;

  Owner({this.id, this.title, this.firstName, this.lastName, this.picture});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['picture'] = this.picture;
    return data;
  }
}
