// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentsBoxAdapter extends TypeAdapter<CommentsBox> {
  @override
  final int typeId = 3;

  @override
  CommentsBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentsBox()
      ..id = fields[1] as int?
      ..name = fields[2] as String?
      ..text = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, CommentsBox obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentsBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
