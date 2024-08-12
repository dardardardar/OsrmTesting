import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:osrmtesting/features/login/domain/entities/account_data.dart';

abstract class RemoteAccountDataState extends Equatable {
  final AccountDataEntity? userData;
  final DioException? error;

  const RemoteAccountDataState({this.userData, this.error});

  @override
  List<Object> get props => [userData!, error!];
}

class RemoteAccountDataLoading extends RemoteAccountDataState {
  const RemoteAccountDataLoading();
}

class RemoteAccountDataDone extends RemoteAccountDataState {
  const RemoteAccountDataDone({required AccountDataEntity data})
      : super(userData: data);
}

class RemoteAccountDataError extends RemoteAccountDataState {
  const RemoteAccountDataError(DioException error) : super(error: error);
}
