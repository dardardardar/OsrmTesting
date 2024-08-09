import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/login/domain/usecases/fetch_account_data.dart';
import 'package:osrmtesting/features/login/domain/usecases/login.dart';
import 'package:osrmtesting/features/login/presentation/blocs/remote_login_event.dart';
import 'package:osrmtesting/features/login/presentation/blocs/remote_login_state.dart';

class RemoteAuthBloc extends Bloc<RemoteAuthEvent, RemoteAuthState> {
  final SendAuthDataUseCase _sendAuthDataUseCase;
  final FetchAccountDataUseCase _fetchAccountDataUseCase;
  RemoteAuthBloc(this._sendAuthDataUseCase, this._fetchAccountDataUseCase)
      : super(const RemoteAuthLoading()) {
    on<SendAuthData>(onSendAuthData);
    on<FetchAccountData>(onFetchRemoteData);
  }

  void onSendAuthData(
      SendAuthData sendAuthData, Emitter<RemoteAuthState> emit) async {
    await _sendAuthDataUseCase(params: sendAuthData.formData);
    final data = await _fetchAccountDataUseCase();
    if (data is SuccessState) {
      emit(RemoteAuthDone(data: data.data!));
    }

    if (data is GeneralErrorState) {
      emit(RemoteAuthError(data.dioException!));
    }
  }

  void onFetchRemoteData(
      FetchAccountData sendAuthData, Emitter<RemoteAuthState> emit) async {}
}
