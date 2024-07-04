import 'package:flutter/material.dart';
import 'package:mbtiles/mbtiles.dart';

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
