import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/core/usecases/usecase.dart';
import 'package:osrmtesting/features/login/domain/entities/account_data.dart';
import 'package:osrmtesting/features/login/domain/repositories/auth_repository.dart';

class FetchAccountDataUseCase
    implements UseCase<BaseState<AccountDataEntity>, void> {
  final IAuthRepository _iAuthRepository;

  FetchAccountDataUseCase(this._iAuthRepository);

  @override
  Future<BaseState<AccountDataEntity>> call({void params}) {
    return _iAuthRepository.fetchAccountData();
  }
}
