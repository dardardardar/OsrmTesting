import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/local/local_map_layer_cubit.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/local/local_map_layer_event.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/remote/remote_map_layer_cubit.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/remote/remote_map_layer_event.dart';
import 'package:osrmtesting/features/home/presentation/pages/home_page.dart';
import 'package:osrmtesting/get_it_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initGetIt();
  Future.delayed(const Duration(milliseconds: 200));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteMapLayerCubit>(
          create: (_) => getIt()..add(const GetRemoteMapLayer()),
        ),
        BlocProvider<LocalMapLayerCubit>(
          create: (_) => getIt()..add(const GetMapTiles()),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
