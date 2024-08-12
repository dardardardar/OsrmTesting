import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/login/domain/usecases/fetch_account_data.dart';
import 'package:osrmtesting/features/login/presentation/blocs/fetch_account_data/fetch_account_data_event.dart';
import 'package:osrmtesting/features/login/presentation/blocs/fetch_account_data/fetch_account_data_state.dart';

class RemoteAccountDataBloc
    extends Bloc<RemoteAccountDataEvent, RemoteAccountDataState> {
  final FetchAccountDataUseCase _fetchAccountDataUseCase;
  RemoteAccountDataBloc(this._fetchAccountDataUseCase)
      : super(const RemoteAccountDataLoading()) {
    on<FetchAccountData>(onFetchRemoteData);
  }

  void onFetchRemoteData(FetchAccountData sendAuthData,
      Emitter<RemoteAccountDataState> emit) async {
    final data = await _fetchAccountDataUseCase();
    if (data is SuccessState) {
      emit(RemoteAccountDataDone(data: data.data!));
    }

    if (data is GeneralErrorState) {
      emit(RemoteAccountDataError(data.dioException!));
    }
  }
}
