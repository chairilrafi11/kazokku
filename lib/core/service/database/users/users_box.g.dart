// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersBoxAdapter extends TypeAdapter<UsersBox> {
  @override
  final int typeId = 1;

  @override
  UsersBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsersBox(
      id: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UsersBox obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
