import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_mbtiles/flutter_map_mbtiles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/app/theme/custom_theme.dart';
import 'package:osrmtesting/app/theme/theme.dart';
import 'package:osrmtesting/core/widgets/customx_widgets.dart';
import 'package:osrmtesting/features/harvest/presentation/cubit/map_layer/local/local_map_layer_cubit.dart';
import 'package:osrmtesting/features/harvest/presentation/cubit/map_layer/local/local_map_layer_state.dart';
import 'package:osrmtesting/features/harvest/presentation/cubit/map_layer/remote/remote_map_layer_cubit.dart';
import 'package:osrmtesting/features/harvest/presentation/cubit/map_layer/remote/remote_map_layer_state.dart';
import 'package:osrmtesting/features/harvest/presentation/widgets/home_widget.dart';
import 'package:flutter/material.dart';

class HarvestPage extends StatefulWidget {
  const HarvestPage({super.key});

  @override
  State<HarvestPage> createState() => _HarvestPageState();
}

class _HarvestPageState extends State<HarvestPage> {
  MbTiles? _mbtiles;
  List<Polyline> _polylines = [];
  List<bool> isVisible = [];
  List<double> size = [];
  int qty = 0;
  bool isNear = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jelajah Pokok',
          style: text18b,
        ),
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
                                            padding: padding8All,
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
                                              child: SvgPicture.asset(
                                                IconPath.tree,
                                                width: 96,
                                                height: 96,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: false,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              padding: padding4All,
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
                  padding: padding16All,
                  child: Column(
                    children: [
                      //debugPanel(_mbtiles!.getMetadata()),
                      const Spacer(),
                      Container(
                        padding: padding8All,
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
                            isNear ? treeDetail() : treeDetailNew(),
                            Padding(
                              padding: padding8All,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CxInputQty(
                                    onQtyChanged: (val) {
                                      setState(() {
                                        qty = val;
                                      });
                                    },
                                    color: primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  CxMainButton(
                                      width: 140,
                                      title: 'Panen',
                                      onTap: () {
                                        print(context.size!.width);
                                      },
                                      icon: IconPath.edit,
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
