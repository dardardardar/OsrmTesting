import 'package:osrmtesting/core/usecases/usecase.dart';
import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';
import 'package:osrmtesting/features/home/domain/repositories/map_layer_repository.dart';

class CacheTreeMarkersUseCase implements UseCase<void, List<TreeMarkerEntity>> {
  final MapLayerRepository _treeMarkerRepository;

  CacheTreeMarkersUseCase(this._treeMarkerRepository);

  @override
  Future<void> call({List<TreeMarkerEntity>? params}) {
    return _treeMarkerRepository.insertCachedTreeMarkers(params!);
  }
}
