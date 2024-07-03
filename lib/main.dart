import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_mbtiles/flutter_map_mbtiles.dart';
import 'package:latlong2/latlong.dart';
import 'package:mbtiles/mbtiles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

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

  Future<String> geoJson() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/Trees.json");
    return data;
  }

  @override
  Widget build(BuildContext context) {
    GeoJsonParser myGeoJson = GeoJsonParser();

    myGeoJson.parseGeoJsonAsString('''{
"type": "FeatureCollection",
"name": "Treee",
"crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
"features": [
{ "type": "Feature", "properties": { "id": 1, "Lat": null, "Long": null }, "geometry": { "type": "Point", "coordinates": [ 112.763499768510727, -1.484361723978728 ] } },
{ "type": "Feature", "properties": { "id": 2, "Lat": null, "Long": null }, "geometry": { "type": "Point", "coordinates": [ 112.763517963533644, -1.483911548230743 ] } },
{ "type": "Feature", "properties": { "id": 3, "Lat": null, "Long": null }, "geometry": { "type": "Point", "coordinates": [ 112.763467927220617, -1.483634167168685 ] } },
{ "type": "Feature", "properties": { "id": 4, "Lat": null, "Long": null }, "geometry": { "type": "Point", "coordinates": [ 112.763536158556548, -1.485112016688344 ] } },
{ "type": "Feature", "properties": { "id": 1, "Lat": "s", "Long": "s" }, "geometry": { "type": "Point", "coordinates": [ 112.763488161015005, -1.48461609517838 ] } }
]
}''');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('flutter_map_mbtiles'),
      ),
      body: FutureBuilder<MbTiles>(
        future: _initMbtiles(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _mbtiles = snapshot.data;
            final metadata = _mbtiles!.getMetadata();
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'MBTiles Name: ${metadata.name}, '
                    'Format: ${metadata.format}',
                  ),
                ),
                Expanded(
                  child: FlutterMap(
                    options: const MapOptions(
                      minZoom: 12,
                      maxZoom: 18,
                      initialZoom: 16,
                      initialCenter:
                          LatLng(-1.48461609517838, 112.763488161015),
                    ),
                    children: [
                      TileLayer(
                        tileProvider: MbTilesTileProvider(
                          mbtiles: _mbtiles!,
                          silenceTileNotFound: true,
                        ),
                      ),
                      MarkerLayer(markers: myGeoJson.markers)
                    ],
                  ),
                ),
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
    // close the open database connection
    _mbtiles?.dispose();
    super.dispose();
  }
}
