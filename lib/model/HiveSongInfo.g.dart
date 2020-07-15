// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HiveSongInfo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveSongInfoAdapter extends TypeAdapter<HiveSongInfo> {
  @override
  final typeId = 3;

  @override
  HiveSongInfo read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveSongInfo()
      ..title = fields[1] as String
      ..artist = fields[2] as String
      ..duration = fields[3] as String
      ..displayName = fields[4] as String
      ..url = fields[6] as String
      ..index = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, HiveSongInfo obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.displayName)
      ..writeByte(6)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.index);
  }
}
