import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_mbtiles/flutter_map_mbtiles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/core/theme/theme.dart';
import 'package:osrmtesting/core/utils/functions.dart';
import 'package:osrmtesting/core/widgets/customx_widgets.dart';
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
  List<Polyline> _polylines = [];
  List<bool> isVisible = [];
  List<double> size = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panen'),
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
                                isVisible.add(false);
                                size.add(30);
                                return Marker(
                                  width: size[i],
                                  point:
                                      LatLng(markers[i].lat!, markers[i].long!),
                                  child: GestureDetector(
                                    onLongPress: () {
                                      setState(() {
                                        isVisible[i] = !isVisible[i];
                                        size[i] = isVisible[i] ? 45 : 30;
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            padding: padding8,
                                            child: Container(
                                              decoration: const ShapeDecoration(
                                                  shape: CircleBorder(),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 3,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: Colors.white),
                                              child: Image.asset(
                                                  'assets/icons/go-harvest-assets.png',
                                                  height: 24),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: false,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              padding: padding4,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 3,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: Colors.green.shade100),
                                              child: AnimatedSwitcher(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                transitionBuilder:
                                                    (Widget child,
                                                        Animation<double>
                                                            animation) {
                                                  return ScaleTransition(
                                                      scale: animation,
                                                      child: child);
                                                },
                                                child: Text(
                                                  markers[i].name!,
                                                  key: ValueKey<String>(
                                                      markers[i].name!),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
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
                  padding: padding16,
                  child: Column(
                    children: [
                      debugPanel(_mbtiles!.getMetadata()),
                      const Spacer(),
                      Container(
                        padding: padding8,
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
                              padding: padding8,
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        CxIcons.tree,
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
                                        CxIcons.info,
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
                            const Padding(
                              padding: padding8,
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: padding8,
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
                                    padding: padding8,
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
                                    padding: padding8,
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
                                    padding: padding8,
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
                                    padding: padding8,
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
                              padding: padding8,
                              child: Row(
                                children: [
                                  CxInputQty(
                                    onQtyChanged: (val) {},
                                    color: primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  CxMainButtonSvg(context,
                                      title: 'Panen',
                                      onTap: () {},
                                      icon: CxIcons.edit,
                                      color: primaryColor)
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
