import 'package:floor/floor.dart';
import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';

@Entity(tableName: 'trees', primaryKeys: ['id'])
class TreeMarkerModel extends TreeMarkerEntity {
  const TreeMarkerModel({
    super.id,
    super.lat,
    super.long,
    super.name,
    super.type,
  });

  factory TreeMarkerModel.fromJson(Map<String, dynamic> json) {
    return TreeMarkerModel(
      id: int.parse(json["id"] ?? '0'),
      lat: double.parse(json["lat"] ?? '0'),
      long: double.parse(json["long"] ?? '0'),
      name: json["name"],
      type: int.parse(json["type"] ?? '1'),
    );
  }
  factory TreeMarkerModel.formEntity(TreeMarkerEntity e) {
    return TreeMarkerModel(
      id: e.id,
      lat: e.lat,
      long: e.long,
      name: e.name,
      type: e.type,
    );
  }
}
