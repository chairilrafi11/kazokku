// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostsBoxAdapter extends TypeAdapter<PostsBox> {
  @override
  final int typeId = 4;

  @override
  PostsBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostsBox(
      id: fields[1] as String?,
      image: fields[2] as String?,
      likes: fields[3] as int?,
      tags: fields[4] as String?,
      text: fields[5] as String?,
      publishDate: fields[6] as String?,
      owner: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PostsBox obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.likes)
      ..writeByte(4)
      ..write(obj.tags)
      ..writeByte(5)
      ..write(obj.text)
      ..writeByte(6)
      ..write(obj.publishDate)
      ..writeByte(7)
      ..write(obj.owner);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostsBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
