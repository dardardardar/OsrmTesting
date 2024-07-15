import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/core/utils/functions.dart';
import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';

Widget debugPanel(MbTilesMetadata metadata) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('MBTiles Name : ${metadata.name}'),
        const SizedBox(
          height: 2,
        ),
        Text('MBTiles Format : ${metadata.format}'),
        const SizedBox(
          height: 2,
        ),
      ],
    ),
  );
}

Marker treeMarker(BuildContext context, {required TreeMarkerEntity tree}) {
  return Marker(
    width: sizeByScreenWidth(context: context, sizePercent: 0.25),
    height: sizeByScreenWidth(context: context, sizePercent: 0.21),
    point: LatLng(tree.lat!, tree.long!),
    child: Stack(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  shadows: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white),
              child:
                  Image.asset('assets/icons/go-harvest-assets.png', height: 24),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.green.shade100),
            child: Text(
              tree.name!,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    ),
  );
}
