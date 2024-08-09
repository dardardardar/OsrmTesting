import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:osrmtesting/features/harvest/data/data_sources/local/database.dart';
import 'package:osrmtesting/features/harvest/data/data_sources/remote/map_layer_api_services.dart';
import 'package:osrmtesting/features/harvest/data/repository/map_layer_repository_impl.dart';
import 'package:osrmtesting/features/harvest/domain/repositories/map_layer_repository.dart';
import 'package:osrmtesting/features/harvest/domain/usecases/get_geojson.dart';
import 'package:osrmtesting/features/harvest/domain/usecases/get_mbtiles.dart';
import 'package:osrmtesting/features/harvest/domain/usecases/get_tree_markers.dart';
import 'package:osrmtesting/features/harvest/presentation/cubit/map_layer/local/local_map_layer_cubit.dart';
import 'package:osrmtesting/features/harvest/presentation/cubit/map_layer/remote/remote_map_layer_cubit.dart';
import 'package:osrmtesting/features/login/data/data_sources/auth_api_services.dart';
import 'package:osrmtesting/features/login/data/repositories/auth_repository.dart';
import 'package:osrmtesting/features/login/domain/repositories/auth_repository.dart';
import 'package:osrmtesting/features/login/domain/usecases/fetch_account_data.dart';
import 'package:osrmtesting/features/login/domain/usecases/login.dart';
import 'package:osrmtesting/features/login/presentation/blocs/remote_login_bloc.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  final db = await $FloorAppDatabase.databaseBuilder('database').build();
  getIt.registerSingleton<AppDatabase>(db);
  getIt.registerSingleton<Dio>(Dio());

  //services
  getIt.registerSingleton<IMapLayerApiService>(IMapLayerApiService(getIt()));
  getIt.registerSingleton<IAuthApiService>(IAuthApiService(getIt()));

  // repository
  getIt.registerSingleton<IMapLayerRepository>(
      MapLayerRepository(getIt(), getIt()));
  getIt.registerSingleton<IAuthRepository>(AuthRepository(getIt()));

  // usecase
  getIt.registerSingleton<FetchAccountDataUseCase>(
      FetchAccountDataUseCase(getIt()));

  getIt.registerSingleton<SendAuthDataUseCase>(SendAuthDataUseCase(getIt()));
  getIt
      .registerSingleton<GetTreeMarkersUseCase>(GetTreeMarkersUseCase(getIt()));
  getIt.registerSingleton<GetMapTilesUseCase>(GetMapTilesUseCase(getIt()));

  getIt.registerSingleton<GetGeoJsonUseCase>(GetGeoJsonUseCase(getIt()));

  //bloc
  getIt.registerFactory<RemoteMapLayerBloc>(
    () {
      return RemoteMapLayerBloc(getIt());
    },
  );
  getIt.registerFactory<LocalMapLayerBloc>(
    () {
      return LocalMapLayerBloc(getIt(), getIt());
    },
  );
  getIt.registerFactory<RemoteAuthBloc>(
    () {
      return RemoteAuthBloc(getIt(), getIt());
    },
  );
}
