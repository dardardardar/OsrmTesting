import 'package:floor/floor.dart';
import 'package:osrmtesting/features/home/data/data_sources/local/dao/map_layer_dao.dart';
import 'package:osrmtesting/features/home/data/models/tree_marker.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [TreeMarkerModel])
abstract class AppDatabase extends FloorDatabase {
  TreeMarkerDao get treesDao;
}
