import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/core/usecases/usecase.dart';
import 'package:osrmtesting/features/harvest/domain/repositories/map_layer_repository.dart';

class GetMapTilesUseCase implements UseCase<BaseState<MbTiles>, void> {
  final MapLayerRepository _mapLayerRepository;

  GetMapTilesUseCase(this._mapLayerRepository);

  @override
  Future<BaseState<MbTiles>> call({void params}) {
    return _mapLayerRepository.getMapTiles();
  }
}
