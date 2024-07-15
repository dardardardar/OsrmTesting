import 'package:osrmtesting/core/usecases/usecase.dart';
import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';
import 'package:osrmtesting/features/home/domain/repositories/map_layer_repository.dart';

class LoadCachedTreeMarkersUseCase
    implements UseCase<List<TreeMarkerEntity>, void> {
  final MapLayerRepository _treeMarkerRepository;

  LoadCachedTreeMarkersUseCase(this._treeMarkerRepository);

  @override
  Future<List<TreeMarkerEntity>> call({void params}) {
    return _treeMarkerRepository.fetchCachedTreeMarkers();
  }
}
