import 'package:equatable/equatable.dart';

class TreeMarkerEntity extends Equatable {
  final int? id;
  final double? lat;
  final double? long;
  final String? name;
  final int? type;
  final String? updatedAt;

  const TreeMarkerEntity(
      {this.id, this.lat, this.long, this.name, this.type, this.updatedAt});

  @override
  List<Object?> get props {
    return [id, lat, long, name, type, updatedAt];
  }
}
