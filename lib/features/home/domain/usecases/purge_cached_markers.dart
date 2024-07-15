import 'package:osrmtesting/core/usecases/usecase.dart';
import 'package:osrmtesting/features/home/domain/repositories/map_layer_repository.dart';

class PurgeCachedTreeMarkersUseCase implements UseCase<void, void> {
  final MapLayerRepository _treeMarkerRepository;

  PurgeCachedTreeMarkersUseCase(this._treeMarkerRepository);

  @override
  Future<void> call({void params}) {
    return _treeMarkerRepository.purgeCachedTreeMarkers();
  }
}
