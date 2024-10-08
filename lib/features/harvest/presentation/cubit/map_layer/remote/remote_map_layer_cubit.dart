import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/harvest/domain/usecases/get_tree_markers.dart';
import 'package:osrmtesting/features/harvest/presentation/cubit/map_layer/remote/remote_map_layer_event.dart';
import 'package:osrmtesting/features/harvest/presentation/cubit/map_layer/remote/remote_map_layer_state.dart';

class RemoteMapLayerBloc
    extends Bloc<RemoteMapLayerEvent, RemoteMapLayerState> {
  final GetTreeMarkersUseCase _getTreeMarkersUseCase;

  RemoteMapLayerBloc(this._getTreeMarkersUseCase)
      : super(const RemoteMapLayerLoading()) {
    on<GetRemoteMapLayer>(onGetTreeMarkers);
  }

  void onGetTreeMarkers(
      GetRemoteMapLayer event, Emitter<RemoteMapLayerState> emit) async {
    final remoteData = await _getTreeMarkersUseCase();

    if (remoteData is SuccessState && remoteData.data!.isNotEmpty) {
      emit(RemoteMapLayerSuccess(remoteData.data!));
    }
    if (remoteData is HttpClient) {
      emit(RemoteMapLayerError(remoteData.dioException!));
    }
  }
}
