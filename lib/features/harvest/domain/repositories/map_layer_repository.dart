import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/harvest/domain/entities/tree_marker.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';

abstract interface class IMapLayerRepository {
  Future<BaseState<List<TreeMarkerEntity>>> getTreeMarkers();
  Future<List<TreeMarkerEntity>> fetchCachedTreeMarkers();
  Future<void> purgeCachedTreeMarkers();
  Future<void> cacheRemoteTreeMarkers(
      {required List<TreeMarkerEntity> remote,
      required List<TreeMarkerEntity> local});
  Future<BaseState<MbTiles>> getMapTiles();
  Future<BaseState<GeoJsonParser>> getGeoJson();
  Future<bool> checkLocalData(TreeMarkerEntity remote);
}
