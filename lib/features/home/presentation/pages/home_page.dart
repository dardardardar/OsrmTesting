import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_mbtiles/flutter_map_mbtiles.dart';
import 'package:latlong2/latlong.dart';
import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/features/home/presentation/widgets/home_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MbTiles? _mbtiles;
  Future<File> copyAssetToFile(String assetFile) async {
    final tempDir = await getTemporaryDirectory();
    final filename = assetFile.split('/').last;
    final file = File('${tempDir.path}/$filename');

    final data = await rootBundle.load(assetFile);
    await file.writeAsBytes(
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      flush: true,
    );
    return file;
  }

  Future<MbTiles> _initMbtiles() async {
    final file = await copyAssetToFile(
      'assets/mbtiles/map.mbtiles',
    );
    return MbTiles(mbtilesPath: file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_map_mbtiles'),
      ),
      body: FutureBuilder<MbTiles>(
        future: _initMbtiles(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _mbtiles = snapshot.data;
            final metadata = _mbtiles!.getMetadata();
            return Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  child: FlutterMap(
                    options: MapOptions(
                      onTap: (tapPosition, point) {
                        if (kDebugMode) {
                          print(point);
                        }
                      },
                      minZoom: 16,
                      maxZoom: 19.5,
                      initialZoom: 17,
                      initialCenter: const LatLng(-1.488226, 112.763424),
                    ),
                    children: [
                      TileLayer(
                        tileProvider: MbTilesTileProvider(
                          mbtiles: _mbtiles!,
                          silenceTileNotFound: true,
                        ),
                      ),
                    ],
                  ),
                ),
                debugPanel(metadata)
              ],
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return const Center(child: CircularProgressIndicator());
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
