import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:osrmtesting/features/home/data/data_sources/remote/map_layer_api_services.dart';
import 'package:osrmtesting/features/home/data/repository/map_layer_repository_impl.dart';
import 'package:osrmtesting/features/home/domain/repositories/map_layer_repository.dart';
import 'package:osrmtesting/features/home/domain/usecases/get_tree_markers.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/remote/remote_map_layer_cubit.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerSingleton<MapLayerApiService>(MapLayerApiService(getIt()));
  getIt.registerSingleton<MapLayerRepository>(MapLayerRepositoryImpl(getIt()));
  getIt
      .registerSingleton<GetTreeMarkersUseCase>(GetTreeMarkersUseCase(getIt()));

  getIt.registerFactory<RemoteMapLayerCubit>(
    () {
      return RemoteMapLayerCubit(getIt());
    },
  );
}
