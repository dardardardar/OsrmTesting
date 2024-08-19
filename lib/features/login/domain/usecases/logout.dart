import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/core/usecases/usecase.dart';
import 'package:osrmtesting/features/login/domain/repositories/auth_repository.dart';

class LogoutUseCase implements UseCase<void, BaseState> {
  final IAuthRepository _iAuthRepository;
  LogoutUseCase(this._iAuthRepository);
  @override
  Future<BaseState> call({void params}) {
    return _iAuthRepository.logout();
  }
}
