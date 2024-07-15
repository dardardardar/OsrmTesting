import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/home/domain/usecases/cache_markers.dart';
import 'package:osrmtesting/features/home/domain/usecases/get_mbtiles.dart';
import 'package:osrmtesting/features/home/domain/usecases/load_cached_markers.dart';
import 'package:osrmtesting/features/home/domain/usecases/purge_cached_markers.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/local/local_map_layer_event.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/local/local_map_layer_state.dart';

class LocalMapLayerCubit extends Bloc<LocalMapLayerEvent, LocalMapLayerState> {
  final GetMapTilesUseCase _getLocalMapLayer;
  final LoadCachedTreeMarkersUseCase _loadCachedTreeMarkers;
  final CacheTreeMarkersUseCase _cacheTreeMarkers;
  final PurgeCachedTreeMarkersUseCase _purgeCachedTreeMarkers;

  LocalMapLayerCubit(this._getLocalMapLayer, this._cacheTreeMarkers,
      this._loadCachedTreeMarkers, this._purgeCachedTreeMarkers)
      : super(const LocalMapLayerLoading()) {
    on<GetMapTiles>(onLoadMapTiles);
    on<CacheMarkers>(onCacheTreeMarkers);
    on<LoadCachedMarkers>(onLoadCachedTreeMarkers);
    on<PurgeCachedMarkers>(onPurgeTreeMarkers);
  }

  Future<void> onLoadMapTiles(
      GetMapTiles event, Emitter<LocalMapLayerState> emit) async {
    final localData = await _getLocalMapLayer();

    if (localData is SuccessState) {
      emit(LocalMapLayerSuccess(mbtiles: localData.data!));
    }
    if (localData is GeneralErrorState) {
      emit(LocalMapLayerError(localData.exception!));
    }
  }

  Future<void> onLoadCachedTreeMarkers(
      LoadCachedMarkers event, Emitter<LocalMapLayerState> emit) async {
    final data = await _loadCachedTreeMarkers();
    emit(LocalMapLayerSuccess(treeMarkers: data));
  }

  Future<void> onCacheTreeMarkers(
      CacheMarkers event, Emitter<LocalMapLayerState> emit) async {
    await _cacheTreeMarkers();
    final data = await _loadCachedTreeMarkers(params: event.markers);
    emit(LocalMapLayerSuccess(treeMarkers: data));
  }

  Future<void> onPurgeTreeMarkers(
      PurgeCachedMarkers event, Emitter<LocalMapLayerState> emit) async {
    await _purgeCachedTreeMarkers();
    final data = await _loadCachedTreeMarkers();
    emit(LocalMapLayerSuccess(treeMarkers: data));
  }
}
