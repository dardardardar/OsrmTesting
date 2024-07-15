import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/core/usecases/usecase.dart';
import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';
import 'package:osrmtesting/features/home/domain/repositories/map_layer_repository.dart';

class GetTreeMarkersUseCase
    implements UseCase<BaseState<List<TreeMarkerEntity>>, void> {
  final MapLayerRepository _treeMarkerRepository;

  GetTreeMarkersUseCase(this._treeMarkerRepository);

  @override
  Future<BaseState<List<TreeMarkerEntity>>> call({void params}) {
    return _treeMarkerRepository.getTreeMarkers();
  }
}

class CacheTreeMarkersUseCase implements UseCase<void, List<TreeMarkerEntity>> {
  final MapLayerRepository _treeMarkerRepository;

  CacheTreeMarkersUseCase(this._treeMarkerRepository);

  @override
  Future<void> call({List<TreeMarkerEntity>? params}) {
    return _treeMarkerRepository.insertCachedTreeMarkers(params!);
  }
}

class LoadCachedTreeMarkersUseCase
    implements UseCase<List<TreeMarkerEntity>, void> {
  final MapLayerRepository _treeMarkerRepository;

  LoadCachedTreeMarkersUseCase(this._treeMarkerRepository);

  @override
  Future<List<TreeMarkerEntity>> call({void params}) {
    return _treeMarkerRepository.fetchCachedTreeMarkers();
  }
}

class PurgeCachedTreeMarkersUseCase implements UseCase<void, void> {
  final MapLayerRepository _treeMarkerRepository;

  PurgeCachedTreeMarkersUseCase(this._treeMarkerRepository);

  @override
  Future<void> call({void params}) {
    return _treeMarkerRepository.purgeCachedTreeMarkers();
  }
}
