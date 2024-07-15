import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:osrmtesting/features/home/data/data_sources/local/database.dart';
import 'package:osrmtesting/features/home/data/data_sources/remote/map_layer_api_services.dart';
import 'package:osrmtesting/features/home/data/repository/map_layer_repository_impl.dart';
import 'package:osrmtesting/features/home/domain/repositories/map_layer_repository.dart';
import 'package:osrmtesting/features/home/domain/usecases/cache_markers.dart';
import 'package:osrmtesting/features/home/domain/usecases/get_mbtiles.dart';
import 'package:osrmtesting/features/home/domain/usecases/get_tree_markers.dart';
import 'package:osrmtesting/features/home/domain/usecases/load_cached_markers.dart';
import 'package:osrmtesting/features/home/domain/usecases/purge_cached_markers.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/local/local_map_layer_cubit.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/remote/remote_map_layer_cubit.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  final db = await $FloorAppDatabase.databaseBuilder('database').build();
  getIt.registerSingleton<AppDatabase>(db);
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerSingleton<MapLayerApiService>(MapLayerApiService(getIt()));
  getIt.registerSingleton<MapLayerRepository>(
      MapLayerRepositoryImpl(getIt(), getIt()));

  getIt
      .registerSingleton<GetTreeMarkersUseCase>(GetTreeMarkersUseCase(getIt()));
  getIt.registerSingleton<GetMapTilesUseCase>(GetMapTilesUseCase(getIt()));
  getIt.registerSingleton<CacheTreeMarkersUseCase>(
      CacheTreeMarkersUseCase(getIt()));
  getIt.registerSingleton<LoadCachedTreeMarkersUseCase>(
      LoadCachedTreeMarkersUseCase(getIt()));
  getIt.registerSingleton<PurgeCachedTreeMarkersUseCase>(
      PurgeCachedTreeMarkersUseCase(getIt()));

  getIt.registerFactory<RemoteMapLayerCubit>(
    () {
      return RemoteMapLayerCubit(getIt());
    },
  );
  getIt.registerFactory<LocalMapLayerCubit>(
    () {
      return LocalMapLayerCubit(getIt(), getIt(), getIt(), getIt());
    },
  );
}
