import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/home/domain/usecases/get_geojson.dart';
import 'package:osrmtesting/features/home/domain/usecases/get_mbtiles.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/local/local_map_layer_event.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/local/local_map_layer_state.dart';

class LocalMapLayerCubit extends Bloc<LocalMapLayerEvent, LocalMapLayerState> {
  final GetMapTilesUseCase _getLocalMapLayer;
  final GetGeoJsonUseCase _geoJsonUseCase;

  LocalMapLayerCubit(this._getLocalMapLayer, this._geoJsonUseCase)
      : super(const LocalMapLayerLoading()) {
    on<GetMapTiles>(onLoadMapTiles);
  }

  Future<void> onLoadMapTiles(
      GetMapTiles event, Emitter<LocalMapLayerState> emit) async {
    final localData = await _getLocalMapLayer();
    final polylines = await _geoJsonUseCase();
    if (localData is SuccessState) {
      emit(LocalMapLayerSuccess(
          mbtiles: localData.data!, polylines: polylines.data!.polylines));
    }
    if (localData is GeneralErrorState) {
      emit(LocalMapLayerError(localData.exception!));
    }
  }
}
