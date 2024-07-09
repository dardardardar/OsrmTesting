import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_mbtiles/flutter_map_mbtiles.dart';
import 'package:latlong2/latlong.dart';
import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/local/local_map_layer_cubit.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/local/local_map_layer_state.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/remote/remote_map_layer_cubit.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/remote/remote_map_layer_state.dart';
import 'package:osrmtesting/features/home/presentation/widgets/home_widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MbTiles? _mbtiles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MbTiles test (Clean Architecture)'),
      ),
      body: BlocBuilder<LocalMapLayerCubit, LocalMapLayerState>(
        builder: (context, state) {
          if (state is LocalMapLayerError) {
            return SizedBox(
              height: double.infinity,
              child: Center(
                child: Text(state.error.toString()),
              ),
            );
          }
          if (state is LocalMapLayerSuccess) {
            _mbtiles = state.mbTiles!;
            return Stack(
              children: [
                BlocBuilder<RemoteMapLayerCubit, RemoteMapLayerState>(
                    builder: (context, state) {
                  if (state is RemoteMapLayerError) {
                    return SizedBox(
                      height: double.infinity,
                      child: Center(
                        child: Text(state.error.toString()),
                      ),
                    );
                  }
                  if (state is RemoteMapLayerSuccess) {
                    final markers = state.treeMarkers ?? [];
                    return SizedBox(
                      height: double.infinity,
                      child: FlutterMap(
                        options: MapOptions(
                          onTap: (tapPosition, point) {
                            if (kDebugMode) {
                              print(point);
                            }
                          },
                          minZoom: 17,
                          maxZoom: 22,
                          initialZoom: 18,
                          initialCenter: const LatLng(-6.228606, 106.830397),
                        ),
                        children: [
                          TileLayer(
                            tileProvider: MbTilesTileProvider(
                              mbtiles: _mbtiles!,
                              silenceTileNotFound: true,
                            ),
                          ),
                          MarkerClusterLayerWidget(
                            options: MarkerClusterLayerOptions(
                              maxClusterRadius: 50,
                              size: const Size(30, 30),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(50),
                              maxZoom: 15,
                              markers: List.generate(markers.length, (i) {
                                return treeMarker(context, tree: markers[i]);
                              }),
                              builder: (context, markers) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green.shade100),
                                  child: Center(
                                    child: Text(
                                      markers.length.toString(),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox(
                    height: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }),
                debugPanel(_mbtiles!.getMetadata())
              ],
            );
          }
          return const SizedBox(
            height: double.infinity,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _mbtiles?.dispose();
    super.dispose();
  }
}
