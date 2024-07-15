import 'dart:io';

import 'package:latlong2/latlong.dart';
import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/core/utils/functions.dart';
import 'package:osrmtesting/features/home/data/data_sources/local/database.dart';
import 'package:osrmtesting/features/home/data/data_sources/remote/map_layer_api_services.dart';
import 'package:dio/dio.dart';
import 'package:osrmtesting/features/home/data/models/tree_marker.dart';

import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';
import 'package:osrmtesting/features/home/domain/repositories/map_layer_repository.dart';

class MapLayerRepositoryImpl implements MapLayerRepository {
  final MapLayerApiService _mapLayerApiService;
  final AppDatabase _database;

  MapLayerRepositoryImpl(this._mapLayerApiService, this._database);

  @override
  Future<BaseState<List<TreeMarkerEntity>>> getTreeMarkers() async {
    try {
      final httpResponse = await _mapLayerApiService.getTreeMarkers();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return SuccessState(httpResponse.data);
      } else {
        return HttpErrorState(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return HttpErrorState(e);
    }
  }

  @override
  Future<BaseState<MbTiles>> getMapTiles() async {
    try {
      final file = await copyAssetToFile(
        'assets/mbtiles/map1.mbtiles',
      );
      if (file.existsSync()) {
        return SuccessState(MbTiles(mbtilesPath: file.path));
      } else {
        return GeneralErrorState(Exception('Map data not avaliable'));
      }
    } on Exception catch (e) {
      return GeneralErrorState(e);
    }
  }

  @override
  Future<BaseState<List<LatLng>>> getPolylines() async {
    try {
      final file = await copyAssetToFile(
        'assets/mbtiles/map1.mbtiles',
      );
      if (file.existsSync()) {
        return SuccessState([]);
      } else {
        return GeneralErrorState(Exception('Map data not avaliable'));
      }
    } on Exception catch (e) {
      return GeneralErrorState(e);
    }
  }

  @override
  Future<List<TreeMarkerEntity>> fetchCachedTreeMarkers() {
    return _database.treesDao.getTrees();
  }

  @override
  Future<void> purgeCachedTreeMarkers() {
    return _database.treesDao.purgeTrees();
  }

  @override
  Future<void> insertCachedTreeMarkers(List<TreeMarkerEntity> e) {
    List<TreeMarkerModel> list = [];
    for (var element in e) {
      list.add(TreeMarkerModel.formEntity(element));
    }
    return _database.treesDao.insertTrees(list);
  }
}
