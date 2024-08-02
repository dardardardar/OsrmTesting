import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:osrmtesting/features/harvest/domain/entities/tree_marker.dart';

abstract class RemoteMapLayerState extends Equatable {
  final List<TreeMarkerEntity>? treeMarkers;
  final DioException? error;

  const RemoteMapLayerState({this.treeMarkers, this.error});

  @override
  List<Object> get props => [treeMarkers!, error!];
}

class RemoteMapLayerLoading extends RemoteMapLayerState {
  const RemoteMapLayerLoading();
}

class RemoteMapLayerSuccess extends RemoteMapLayerState {
  const RemoteMapLayerSuccess(List<TreeMarkerEntity> treeMarkers)
      : super(treeMarkers: treeMarkers);
}

class RemoteMapLayerError extends RemoteMapLayerState {
  const RemoteMapLayerError(DioException error) : super(error: error);
}
