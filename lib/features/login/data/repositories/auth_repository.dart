import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/login/data/data_sources/auth_api_services.dart';
import 'package:osrmtesting/features/login/data/model/auth_form.dart';
import 'package:osrmtesting/features/login/domain/entities/account_data.dart';
import 'package:osrmtesting/features/login/domain/entities/auth_form.dart';
import 'package:osrmtesting/features/login/domain/repositories/auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final IAuthApiService _authApiService;

  AuthRepository(this._authApiService);

  @override
  Future<BaseState> login(AuthFormEntity data) async {
    try {
      final httpResponse =
          await _authApiService.login(AuthFormModel.formEntity(data).toJson());
      const storage = FlutterSecureStorage();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        await storage.write(key: 'token', value: httpResponse.data.jwt);
        return const SuccessState(message: 'Saved');
      }
      if (httpResponse.response.statusCode == HttpStatus.badRequest) {
        return InvalidCredentialState(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions));
      }
      return HttpErrorState(
          ex: DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions));
    } on DioException catch (e) {
      return HttpErrorState(ex: e);
    } on Exception catch (e) {
      return GeneralErrorState(e);
    }
  }

  @override
  Future<BaseState<AccountDataEntity>> fetchAccountData() async {
    try {
      const storage = FlutterSecureStorage();
      final value = await storage.read(key: 'token');
      final httpResponse = await _authApiService
          .fetchAccountData(value != null ? 'Bearer $value' : '');
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return SuccessState(data: httpResponse.data);
      }
      if (httpResponse.response.statusCode == HttpStatus.forbidden) {
        return UnauthorizedState(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions));
      }
      return HttpErrorState(
          ex: DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions));
    } on DioException catch (e) {
      return HttpErrorState(ex: e);
    } on Exception catch (e) {
      return GeneralErrorState(e);
    }
  }

  @override
  Future<BaseState> logout() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'token');
      return const SuccessState(message: 'done');
    } on Exception catch (e) {
      return GeneralErrorState(e);
    }
  }
}
