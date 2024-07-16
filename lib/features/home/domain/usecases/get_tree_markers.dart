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
