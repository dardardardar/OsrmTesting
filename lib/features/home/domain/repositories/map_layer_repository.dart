import 'package:latlong2/latlong.dart';
import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';

abstract class MapLayerRepository {
  Future<BaseState<List<TreeMarkerEntity>>> getTreeMarkers();
  Future<List<TreeMarkerEntity>> fetchCachedTreeMarkers();
  Future<void> purgeCachedTreeMarkers();
  Future<void> insertCachedTreeMarkers(List<TreeMarkerEntity> tree);
  Future<BaseState<MbTiles>> getMapTiles();
  Future<BaseState<List<LatLng>>> getPolylines();
}
