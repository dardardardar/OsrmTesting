import 'package:dio/dio.dart';
import 'package:osrmtesting/core/const/strings.dart';
import 'package:osrmtesting/features/harvest/data/models/tree_marker.dart';

import 'package:retrofit/retrofit.dart';

part 'map_layer_api_services.g.dart';

@RestApi(baseUrl: baseURL)
abstract interface class IMapLayerApiService {
  factory IMapLayerApiService(Dio dio) = _IMapLayerApiService;

  @GET('/locations?type=1')
  Future<HttpResponse<List<TreeMarkerModel>>> getTreeMarkers();
}
