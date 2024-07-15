import 'package:equatable/equatable.dart';
import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';

abstract class LocalMapLayerEvent extends Equatable {
  final TreeMarkerEntity? markers;

  const LocalMapLayerEvent({this.markers});

  @override
  List<Object> get props => [markers!];
}

class GetMapTiles extends LocalMapLayerEvent {
  const GetMapTiles();
}

class CacheMarkers extends LocalMapLayerEvent {
  const CacheMarkers();
}

class LoadCachedMarkers extends LocalMapLayerEvent {
  const LoadCachedMarkers();
}

class PurgeCachedMarkers extends LocalMapLayerEvent {
  const PurgeCachedMarkers();
}

class ParseGeoJson extends LocalMapLayerEvent {
  const ParseGeoJson();
}
