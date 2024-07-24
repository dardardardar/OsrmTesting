// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:mbtiles/mbtiles.dart';
import 'package:osrmtesting/core/const/strings.dart';
import 'package:osrmtesting/core/theme/custom_theme.dart';
import 'package:osrmtesting/core/theme/theme.dart';
import 'package:osrmtesting/core/utils/functions.dart';
import 'package:osrmtesting/features/home/domain/entities/tree_marker.dart';

Widget debugPanel(MbTilesMetadata metadata) {
  return Padding(
    padding: padding8,
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

Marker treeMarker(BuildContext context,
    {required TreeMarkerEntity tree, Function()? onLongPress}) {
  return Marker(
    width: sizeByScreenWidth(context: context, sizePercent: 0.25),
    height: sizeByScreenWidth(context: context, sizePercent: 0.21),
    point: LatLng(tree.lat!, tree.long!),
    child: GestureDetector(
      onLongPress: () {
        // if (kDebugMode) {
        //   print(tree.name);
        // }
        // showModalBottomSheet(
        //   context: context,
        //   builder: (context) {
        //     return Container(
        //       padding: padding8,
        //       width: double.infinity,
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [Text(tree.name!)],
        //       ),
        //     );
        //   },
        // );
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
              padding: padding4,
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
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Text(
                  tree.name!,
                  key: ValueKey<String>(tree.name!),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget treeDetailNew() {
  return Container(
    padding: padding8,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              IconPath.info,
              width: 28,
              colorFilter:
                  const ColorFilter.mode(disabledColor, BlendMode.srcIn),
            ),
            spacer8w,
            Expanded(
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    treeNotFoundTitle,
                    style: text14,
                  ),
                  Text(
                    treeNotFoundDetail,
                    style: text10,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
        spacer8h
      ],
    ),
  );
}

Widget treeDetail() {
  List<dynamic> datas = ['K37-50', 'K37', '2', 'Ancak 1', 'AFD 6'];
  return Column(
    children: [
      Padding(
        padding: padding8,
        child: Row(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  IconPath.tree,
                  width: 18,
                ),
                spacer8w,
                Text('Detail Pokok'),
              ],
            ),
            Spacer(),
            Row(
              children: [
                SvgPicture.asset(
                  IconPath.info,
                  width: 18,
                  colorFilter:
                      const ColorFilter.mode(disabledColor, BlendMode.srcIn),
                ),
                // Image.asset(
                //   'assets/icons/info.png',
                //   color: disabledColor,
                // ),
                spacer8w,
                Text(
                  'Siap Panen',
                  style: text14.copyWith(color: disabledColor),
                ),
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: padding8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            treeDetailLabels.length,
            (i) {
              return Padding(
                padding: padding4,
                child: Column(
                  children: [
                    Text(
                      treeDetailLabels[i],
                      style: text10,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      datas[i].toString(),
                      style: text14b,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ],
  );
}
