import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/core/utils/functions.dart';
import 'package:osrmtesting/features/harvest/data/data_sources/local/database.dart';
import 'package:osrmtesting/features/harvest/data/data_sources/remote/map_layer_api_services.dart';
import 'package:dio/dio.dart';
import 'package:osrmtesting/features/harvest/data/models/tree_marker.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:osrmtesting/features/harvest/domain/entities/tree_marker.dart';
import 'package:osrmtesting/features/harvest/domain/repositories/map_layer_repository.dart';

class MapLayerRepositoryImpl implements MapLayerRepository {
  final MapLayerApiService _mapLayerApiService;
  final AppDatabase _database;

  MapLayerRepositoryImpl(this._mapLayerApiService, this._database);

  @override
  Future<BaseState<List<TreeMarkerEntity>>> getTreeMarkers() async {
    try {
      final httpResponse = await _mapLayerApiService.getTreeMarkers();
      final data = await fetchCachedTreeMarkers();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        cacheRemoteTreeMarkers(remote: httpResponse.data, local: data);
        return SuccessState(data: httpResponse.data);
      }
      return SuccessState(data: data);
    } on DioException catch (e) {
      final data = await fetchCachedTreeMarkers();
      return SuccessState(data: data, message: e.message);
    } on Exception catch (e) {
      return GeneralErrorState(e);
    }
  }

  @override
  Future<BaseState<MbTiles>> getMapTiles() async {
    try {
      final file = await copyAssetToFile(
        'assets/mbtiles/map1.mbtiles',
      );
      if (file.existsSync()) {
        return SuccessState(data: MbTiles(mbtilesPath: file.path));
      } else {
        return GeneralErrorState(Exception('Map data not avaliable'));
      }
    } on Exception catch (e) {
      return GeneralErrorState(e);
    }
  }

  @override
  Future<BaseState<GeoJsonParser>> getGeoJson() async {
    try {
      final response =
          await rootBundle.loadString('assets/geojson/Route.geojson');
      final geoJson = GeoJsonParser();
      geoJson.parseGeoJsonAsString(response);
      return SuccessState(data: geoJson);
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
  Future<void> cacheRemoteTreeMarkers(
      {required List<TreeMarkerEntity> remote,
      required List<TreeMarkerEntity> local}) {
    List<TreeMarkerModel> list = [];

    if (local.isNotEmpty) {
      purgeCachedTreeMarkers();
    }
    for (var element in remote) {
      list.add(TreeMarkerModel.formEntity(element));
    }

    return _database.treesDao.insertTrees(list);
  }

  @override
  Future<bool> checkLocalData(TreeMarkerEntity remote) async {
    final local = await fetchCachedTreeMarkers();
    if (local.isEmpty) {
      return true;
    }
    if (remote.updatedAt != local.first.updatedAt) {
      return true;
    }
    return false;
  }
}
