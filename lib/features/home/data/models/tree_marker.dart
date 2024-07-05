import 'package:latlong2/latlong.dart';
import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';

class TreeMarkerModel extends TreeMarkerEntity {
  const TreeMarkerModel({
    int? id,
    LatLng? coordinate,
    String? name,
    int? type,
  });

  factory TreeMarkerModel.fromJson(Map<String, dynamic> json) =>
      TreeMarkerModel(
        id: int.parse(json["id"] ?? '0'),
        coordinate: LatLng(double.parse(json["lat"] ?? '0'),
            double.parse(json["long"] ?? '0')),
        name: json["name"],
        type: int.parse(json["type"] ?? '1'),
      );
}
