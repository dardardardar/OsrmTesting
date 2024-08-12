import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/login/domain/usecases/fetch_account_data.dart';
import 'package:osrmtesting/features/login/domain/usecases/login.dart';
import 'package:osrmtesting/features/login/presentation/blocs/remote_login_event.dart';
import 'package:osrmtesting/features/login/presentation/blocs/remote_login_state.dart';

class RemoteAuthBloc extends Bloc<RemoteAuthEvent, RemoteAuthState> {
  final SendAuthDataUseCase _sendAuthDataUseCase;
  RemoteAuthBloc(this._sendAuthDataUseCase) : super(const RemoteAuthLoading()) {
    on<SendAuthData>(onSendAuthData);
  }

  void onSendAuthData(
      SendAuthData sendAuthData, Emitter<RemoteAuthState> emit) async {
    final data = await _sendAuthDataUseCase(params: sendAuthData.formData);
    if (data is SuccessState) {
      emit(const RemoteAuthDone());
    }

    if (data is GeneralErrorState) {
      emit(RemoteAuthError(data.dioException!));
    }
  }
}
