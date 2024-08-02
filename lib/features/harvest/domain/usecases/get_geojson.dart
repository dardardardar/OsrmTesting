import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/core/usecases/usecase.dart';
import 'package:osrmtesting/features/harvest/domain/repositories/map_layer_repository.dart';

class GetGeoJsonUseCase implements UseCase<BaseState<GeoJsonParser>, void> {
  final MapLayerRepository _mapLayerRepository;

  GetGeoJsonUseCase(this._mapLayerRepository);

  @override
  Future<BaseState<GeoJsonParser>> call({void params}) {
    return _mapLayerRepository.getGeoJson();
  }
}
