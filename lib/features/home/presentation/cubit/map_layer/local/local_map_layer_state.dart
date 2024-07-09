import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:mbtiles/mbtiles.dart';

abstract class LocalMapLayerState extends Equatable {
  final MbTiles? mbTiles;
  final List<LatLng>? polylines;
  final Exception? error;

  const LocalMapLayerState({this.mbTiles, this.polylines, this.error});

  @override
  List<Object> get props => [mbTiles!, polylines!, error!];
}

class LocalMapLayerLoading extends LocalMapLayerState {
  const LocalMapLayerLoading();
}

class LocalMapLayerSuccess extends LocalMapLayerState {
  const LocalMapLayerSuccess({MbTiles? mbtiles, super.polylines})
      : super(mbTiles: mbtiles);
}

class LocalMapLayerError extends LocalMapLayerState {
  const LocalMapLayerError(Exception error) : super(error: error);
}
