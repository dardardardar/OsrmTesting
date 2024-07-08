import 'package:latlong2/latlong.dart';
import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';

class TreeMarkerModel extends TreeMarkerEntity {
  const TreeMarkerModel({
    super.id,
    super.coordinate,
    super.name,
    super.type,
  });

  factory TreeMarkerModel.fromJson(Map<String, dynamic> json) {
    return TreeMarkerModel(
      id: int.parse(json["id"] ?? '0'),
      coordinate: LatLng(
          double.parse(json["lat"] ?? '0'), double.parse(json["long"] ?? '0')),
      name: json["name"],
      type: int.parse(json["type"] ?? '1'),
    );
  }
}
