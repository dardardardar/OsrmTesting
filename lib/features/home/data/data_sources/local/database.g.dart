// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TreeMarkerDao? _treesDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `trees` (`id` INTEGER, `lat` REAL, `long` REAL, `name` TEXT, `type` INTEGER, `updatedAt` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TreeMarkerDao get treesDao {
    return _treesDaoInstance ??= _$TreeMarkerDao(database, changeListener);
  }
}

class _$TreeMarkerDao extends TreeMarkerDao {
  _$TreeMarkerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _treeMarkerModelInsertionAdapter = InsertionAdapter(
            database,
            'trees',
            (TreeMarkerModel item) => <String, Object?>{
                  'id': item.id,
                  'lat': item.lat,
                  'long': item.long,
                  'name': item.name,
                  'type': item.type,
                  'updatedAt': item.updatedAt
                }),
        _treeMarkerModelUpdateAdapter = UpdateAdapter(
            database,
            'trees',
            ['id'],
            (TreeMarkerModel item) => <String, Object?>{
                  'id': item.id,
                  'lat': item.lat,
                  'long': item.long,
                  'name': item.name,
                  'type': item.type,
                  'updatedAt': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TreeMarkerModel> _treeMarkerModelInsertionAdapter;

  final UpdateAdapter<TreeMarkerModel> _treeMarkerModelUpdateAdapter;

  @override
  Future<List<TreeMarkerModel>> getTrees() async {
    return _queryAdapter.queryList('select * from trees',
        mapper: (Map<String, Object?> row) => TreeMarkerModel(
            id: row['id'] as int?,
            lat: row['lat'] as double?,
            long: row['long'] as double?,
            name: row['name'] as String?,
            type: row['type'] as int?,
            updatedAt: row['updatedAt'] as String?));
  }

  @override
  Future<void> purgeTrees() async {
    await _queryAdapter.queryNoReturn('delete from trees');
  }

  @override
  Future<TreeMarkerModel?> getSingleTree(String id) async {
    return _queryAdapter.query('select * from trees where id = ?1',
        mapper: (Map<String, Object?> row) => TreeMarkerModel(
            id: row['id'] as int?,
            lat: row['lat'] as double?,
            long: row['long'] as double?,
            name: row['name'] as String?,
            type: row['type'] as int?,
            updatedAt: row['updatedAt'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> insertTrees(List<TreeMarkerModel> trees) async {
    await _treeMarkerModelInsertionAdapter.insertList(
        trees, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTrees(TreeMarkerModel trees) async {
    await _treeMarkerModelUpdateAdapter.update(trees, OnConflictStrategy.abort);
  }
}
