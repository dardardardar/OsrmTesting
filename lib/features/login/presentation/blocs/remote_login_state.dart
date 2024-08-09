import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:osrmtesting/features/login/domain/entities/account_data.dart';

abstract class RemoteAuthState extends Equatable {
  final AccountDataEntity? userData;
  final DioException? error;

  const RemoteAuthState({this.userData, this.error});

  @override
  List<Object> get props => [userData!, error!];
}

class RemoteAuthLoading extends RemoteAuthState {
  const RemoteAuthLoading();
}

class RemoteAuthDone extends RemoteAuthState {
  const RemoteAuthDone({required AccountDataEntity data})
      : super(userData: data);
}

class RemoteAuthError extends RemoteAuthState {
  const RemoteAuthError(DioException error) : super(error: error);
}
