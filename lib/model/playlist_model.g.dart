// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePlaylistModelAdapter extends TypeAdapter<HivePlaylistModel> {
  @override
  final typeId = 4;

  @override
  HivePlaylistModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePlaylistModel()
      ..name = fields[0] as String
      ..urls = (fields[1] as List)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, HivePlaylistModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.urls);
  }
}
