import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteAuthState extends Equatable {
  final DioException? error;

  const RemoteAuthState({this.error});

  @override
  List<Object> get props => [error!];
}

class RemoteAuthLoading extends RemoteAuthState {
  const RemoteAuthLoading();
}

class RemoteAuthDone extends RemoteAuthState {
  const RemoteAuthDone();
}

class RemoteAuthError extends RemoteAuthState {
  const RemoteAuthError(DioException error) : super(error: error);
}
