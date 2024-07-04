import 'package:latlong2/latlong.dart';
import 'package:osrmtesting/features/home/domain/entities/trees.dart';

class TreeModel extends TreeEntity {
  const TreeModel({
    int? id,
    LatLng? coordinate,
    String? name,
    int? type,
  });

  factory TreeModel.fromJson(Map<String, dynamic> json) => TreeModel(
        id: int.parse(json["id"] ?? '0'),
        coordinate: LatLng(double.parse(json["lat"] ?? '0'),
            double.parse(json["long"] ?? '0')),
        name: json["name"],
        type: int.parse(json["type"] ?? '1'),
      );
}
