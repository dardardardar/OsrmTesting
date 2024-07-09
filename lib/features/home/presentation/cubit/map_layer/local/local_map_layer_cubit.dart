import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/home/domain/usecases/get_mbtiles.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/local/local_map_layer_event.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/local/local_map_layer_state.dart';

class LocalMapLayerCubit extends Bloc<LocalMapLayerEvent, LocalMapLayerState> {
  final GetMapTilesUseCase _getLocalMapLayer;

  LocalMapLayerCubit(this._getLocalMapLayer)
      : super(const LocalMapLayerLoading()) {
    on<GetLocalMapLayer>(onLoadMapTiles);
  }

  void onLoadMapTiles(
      GetLocalMapLayer event, Emitter<LocalMapLayerState> emit) async {
    final localData = await _getLocalMapLayer();

    if (localData is SuccessState) {
      emit(LocalMapLayerSuccess(mbtiles: localData.data!));
    }
    if (localData is GeneralErrorState) {
      emit(LocalMapLayerError(localData.exception!));
    }
  }
}
