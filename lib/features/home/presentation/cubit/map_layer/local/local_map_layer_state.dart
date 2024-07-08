import 'package:equatable/equatable.dart';
import 'package:mbtiles/mbtiles.dart';

abstract class LocalMapLayerState extends Equatable {
  final MbTiles? mbTiles;
  final Exception? error;

  const LocalMapLayerState({this.mbTiles, this.error});

  @override
  List<Object> get props => [mbTiles!, error!];
}

class LocalMapLayerLoading extends LocalMapLayerState {
  const LocalMapLayerLoading();
}

class LocalMapLayerSuccess extends LocalMapLayerState {
  const LocalMapLayerSuccess(MbTiles mbtiles) : super(mbTiles: mbtiles);
}

class LocalMapLayerError extends LocalMapLayerState {
  const LocalMapLayerError(Exception error) : super(error: error);
}
