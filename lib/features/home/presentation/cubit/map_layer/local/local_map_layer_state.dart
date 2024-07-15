import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';

abstract class LocalMapLayerState extends Equatable {
  final MbTiles? mbTiles;
  final List<LatLng>? polylines;
  final List<TreeMarkerEntity>? treeMarkers;
  final Exception? error;

  const LocalMapLayerState(
      {this.mbTiles, this.polylines, this.treeMarkers, this.error});

  @override
  List<Object> get props => [mbTiles!, polylines!, treeMarkers!, error!];
}

class LocalMapLayerLoading extends LocalMapLayerState {
  const LocalMapLayerLoading();
}

class LocalMapLayerSuccess extends LocalMapLayerState {
  const LocalMapLayerSuccess(
      {MbTiles? mbtiles, super.polylines, super.treeMarkers})
      : super(mbTiles: mbtiles);
}

class LocalMapLayerError extends LocalMapLayerState {
  const LocalMapLayerError(Exception error) : super(error: error);
}
