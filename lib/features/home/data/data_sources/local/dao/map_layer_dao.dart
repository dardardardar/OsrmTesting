import 'package:floor/floor.dart';
import 'package:osrmtesting/features/home/data/models/tree_marker.dart';

@dao
abstract class TreeMarkerDao {
  @Query('select * from trees')
  Future<List<TreeMarkerModel>> getTrees();
  @Insert()
  Future<void> insertTrees(List<TreeMarkerModel> trees);
  @Update()
  Future<void> updateTrees(TreeMarkerModel trees);
  @Query('delete from trees')
  Future<void> purgeTrees();
  @Query('select * from trees where id = :id')
  Future<TreeMarkerModel?> getSingleTree(String id);
}
