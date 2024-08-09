import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/core/usecases/usecase.dart';
import 'package:osrmtesting/features/login/domain/entities/auth_form.dart';
import 'package:osrmtesting/features/login/domain/repositories/auth_repository.dart';

class SendAuthDataUseCase implements UseCase<void, AuthFormEntity> {
  final IAuthRepository _iAuthRepository;

  SendAuthDataUseCase(this._iAuthRepository);

  @override
  Future<BaseState> call({AuthFormEntity? params}) {
    return _iAuthRepository.login(params!);
  }
}
