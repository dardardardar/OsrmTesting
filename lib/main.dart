import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osrmtesting/app/theme/custom_theme.dart';
import 'package:osrmtesting/features/harvest/presentation/cubit/map_layer/local/local_map_layer_cubit.dart';
import 'package:osrmtesting/features/harvest/presentation/cubit/map_layer/local/local_map_layer_event.dart';
import 'package:osrmtesting/features/harvest/presentation/cubit/map_layer/remote/remote_map_layer_cubit.dart';
import 'package:osrmtesting/features/harvest/presentation/cubit/map_layer/remote/remote_map_layer_event.dart';
import 'package:osrmtesting/features/home/presentation/pages/home_page.dart';
import 'package:osrmtesting/features/login/presentation/blocs/fetch_account_data/fetch_account_data_bloc.dart';
import 'package:osrmtesting/features/login/presentation/blocs/fetch_account_data/fetch_account_data_event.dart';
import 'package:osrmtesting/features/login/presentation/blocs/fetch_account_data/fetch_account_data_state.dart';
import 'package:osrmtesting/features/login/presentation/blocs/remote_login_bloc.dart';
import 'package:osrmtesting/features/login/presentation/blocs/remote_login_event.dart';
import 'package:osrmtesting/features/login/presentation/pages/login_page.dart';
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
        BlocProvider<RemoteMapLayerBloc>(
          create: (_) => getIt()..add(const GetRemoteMapLayer()),
        ),
        BlocProvider<LocalMapLayerBloc>(
          create: (_) => getIt()..add(const GetMapTiles()),
        ),
        BlocProvider<RemoteAuthBloc>(
          create: (_) => getIt()..add(const SendAuthData()),
        ),
        BlocProvider<RemoteAccountDataBloc>(
          create: (_) => getIt()..add(const FetchAccountData()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true, colorScheme: colorSchemes),
        home: BlocBuilder<RemoteAccountDataBloc, RemoteAccountDataState>(
          builder: (context, state) {
            if (state is RemoteAccountDataError) {
              return const LoginPage(brand: 'eee');
            }
            return const HomePage();
          },
        ),
        // home: const LoginPage(
        //   brand: 'Testing',
        // ),
      ),
    );
  }
}
