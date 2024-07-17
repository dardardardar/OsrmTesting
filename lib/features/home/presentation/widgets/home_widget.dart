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
Widget widgetPanel(MbTilesMetadata metadata){
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(children: [
      debugPanel(metadata),
      Spacer(),
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white
        ),
        child:  Column(
          children: [
             const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle),
                      SizedBox(width: 8,),
                      Text('Detail Pokok'),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.info_outline),
                      SizedBox(width: 8,),
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
                        SizedBox(height: 2,),
                        Text('data')
                      ],
                    ),
                  ),
                  SizedBox(width:24,),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text('Blok'),
                        SizedBox(height: 2,),
                        Text('data')
                      ],
                    ),
                  ),
                  SizedBox(width:24,),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text('Baris'),
                        SizedBox(height: 2,),
                        Text('data')
                      ],
                    ),
                  ),
                  SizedBox(width:24,),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text('Ancak'),
                        SizedBox(height: 2,),
                        Text('data')
                      ],
                    ),
                  ),
                  SizedBox(width:24,),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text('Afdeling'),
                        SizedBox(height: 2,),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: CircleBorder(side: BorderSide(
                              width: 1,
                              color: Colors.green
                            )),

                          ),
                          child: Icon(Icons.remove,color: Colors.green,),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('0'),
                      ),
                      InkWell(
                        onTap: (){},
                        child: Container(
                          decoration: ShapeDecoration(
                            shape: CircleBorder(side: BorderSide(
                                width: 1,
                                color: Colors.green
                            )),

                          ),
                          child: Icon(Icons.add,color: Colors.green,),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: (){},
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Panen'),
                    ),
                  )
                ],
              ),
            )

          ],
        ),
      )
    ],),
  );
}

Marker treeMarker(BuildContext context, {required TreeMarkerEntity tree}) {
  return Marker(
    width: sizeByScreenWidth(context: context, sizePercent: 0.25),
    height: sizeByScreenWidth(context: context, sizePercent: 0.21),
    point: LatLng(tree.lat!, tree.long!),
    child: GestureDetector(
      onLongPress: () {
        print(tree.name);
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.fromLTRB(8, 32, 8, 8),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text(tree.name!)],
              ),
            );
          },
        );
      },
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
                child: Image.asset('assets/icons/go-harvest-assets.png',
                    height: 24),
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
    ),
  );
}
