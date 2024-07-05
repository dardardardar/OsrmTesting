import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class TreeMarkerEntity extends Equatable {
  final int? id;
  final LatLng? coordinate;
  final String? name;
  final int? type;

  const TreeMarkerEntity({this.id, this.coordinate, this.name, this.type});

  @override
  List<Object?> get props {
    return [id, coordinate, name, type];
  }
}
