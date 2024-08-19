import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/login/domain/entities/account_data.dart';
import 'package:osrmtesting/features/login/domain/entities/auth_form.dart';

abstract interface class IAuthRepository {
  IAuthRepository(Object object);

  Future<BaseState> login(AuthFormEntity data);
  Future<BaseState<AccountDataEntity>> fetchAccountData();
  Future<BaseState> logout();
}
