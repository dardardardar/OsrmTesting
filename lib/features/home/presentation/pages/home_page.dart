import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_mbtiles/flutter_map_mbtiles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/core/const/colors.dart';
import 'package:osrmtesting/core/const/icons.dart';
import 'package:osrmtesting/core/utils/functions.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/local/local_map_layer_cubit.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/local/local_map_layer_state.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/remote/remote_map_layer_cubit.dart';
import 'package:osrmtesting/features/home/presentation/cubit/map_layer/remote/remote_map_layer_state.dart';
import 'package:osrmtesting/features/home/presentation/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MbTiles? _mbtiles;
  List<Polyline> _polylines = [];
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
            _polylines = state.polylines!;
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
                          PolylineLayer(
                              polylines: List.generate(_polylines.length, (i) {
                            return Polyline(
                                points: _polylines[i].points,
                                color: Colors.purple,
                                strokeWidth: 3,
                                useStrokeWidthInMeter: true);
                          })),
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
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      debugPanel(_mbtiles!.getMetadata()),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              )
                            ],
                            color: Colors.white),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        CustomIcons.Tree,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text('Detail Pokok'),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        CustomIcons.Info,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text('Siap Panen'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text('Pokok'),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text('data')
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text('Blok'),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text('data')
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text('Baris'),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text('data')
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text('Ancak'),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text('data')
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text('Afdeling'),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text('data')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // InkWell(
                                        //   onTap: () {},
                                        //   child: Container(
                                        //     padding: EdgeInsets.all(8),
                                        //     decoration: ShapeDecoration(
                                        //       shape: CircleBorder(
                                        //           side: BorderSide(
                                        //               width: 1,
                                        //               color: Colors.green)),
                                        //     ),
                                        //     child: SvgPicture.asset(
                                        //         CustomIcons.Minus),
                                        //   ),
                                        // ),
                                        OutlinedButton(
                                          onPressed: () =>
                                              print("it's pressed"),
                                          style: OutlinedButton.styleFrom(
                                            overlayColor: Colors.green,
                                            side: BorderSide(
                                                width: 1.5,
                                                color: primaryColor),
                                            shape: CircleBorder(),
                                          ),
                                          child: SvgPicture.asset(
                                              CustomIcons.Minus,
                                              colorFilter: ColorFilter.mode(
                                                  primaryColor,
                                                  BlendMode.srcIn)),
                                        ),
                                        SizedBox(
                                          width: 48,
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintText: '0',
                                            ),
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () =>
                                              print("it's pressed"),
                                          style: OutlinedButton.styleFrom(
                                            overlayColor: Colors.green,
                                            side: BorderSide(
                                                width: 1.5,
                                                color: primaryColor),
                                            shape: CircleBorder(),
                                          ),
                                          child: SvgPicture.asset(
                                              CustomIcons.Plus,
                                              colorFilter: ColorFilter.mode(
                                                  primaryColor,
                                                  BlendMode.srcIn)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(CustomIcons.Info),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text('Panen'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
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
