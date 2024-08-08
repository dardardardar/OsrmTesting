import 'package:dio/dio.dart' hide Headers;
import 'package:osrmtesting/core/const/strings.dart';
import 'package:osrmtesting/features/login/data/model/account_data.dart';
import 'package:osrmtesting/features/login/data/model/auth_response.dart';

import 'package:retrofit/retrofit.dart';

part 'auth_api_services.g.dart';

@RestApi(baseUrl: baseURL)
abstract interface class IAuthApiService {
  factory IAuthApiService(Dio dio) = _IAuthApiService;

  @POST('/login')
  Future<HttpResponse<AuthResponseModel>> login(
    @Body() Map<String, dynamic> data,
  );

  @GET('/users')
  Future<HttpResponse<AccountDataModel>> fetchAccountData(
      @Header('Authorization') String jwt);
}
