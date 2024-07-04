import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/home/domain/entities/trees.dart';

abstract class TreeRepository {
  Future<BaseState<List<TreeEntity>>> getTreeMarkers();
}
