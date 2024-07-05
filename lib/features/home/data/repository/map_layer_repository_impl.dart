import 'dart:io';

import 'package:osrmtesting/core/const/const.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/home/data/data_sources/remote/map_layer_api_services.dart';
import 'package:dio/dio.dart';

import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';
import 'package:osrmtesting/features/home/domain/repositories/map_layer_repository.dart';

class MapLayerRepositoryImpl implements MapLayerRepository {
  final MapLayerApiService _mapLayerApiService;

  MapLayerRepositoryImpl(this._mapLayerApiService);

  @override
  Future<BaseState<List<TreeMarkerEntity>>> getTreeMarkers() async {
    try {
      final httpResponse =
          await _mapLayerApiService.getTreeMarkers(type: treeMarkersType);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return SuccessState(httpResponse.data);
      } else {
        return ErrorState(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return ErrorState(e);
    }
  }
}
