import 'package:dio/dio.dart';
import 'package:osrmtesting/core/const/const.dart';
import 'package:osrmtesting/features/home/data/models/tree_marker.dart';

import 'package:retrofit/retrofit.dart';

part 'map_layer_api_services.g.dart';

@RestApi(baseUrl: baseURL)
abstract class MapLayerApiService {
  factory MapLayerApiService(Dio dio) = _MapLayerApiService;

  @GET('/locations?type=1')
  Future<HttpResponse<List<TreeMarkerModel>>> getTreeMarkers();

}
