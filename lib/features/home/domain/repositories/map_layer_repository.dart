import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';

abstract class MapLayerRepository {
  Future<BaseState<List<TreeMarkerEntity>>> getTreeMarkers();
  Future<BaseState<MbTiles>> getMapTiles();
}
