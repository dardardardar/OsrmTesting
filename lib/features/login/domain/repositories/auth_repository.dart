import 'package:osrmtesting/core/resources/base_state.dart';
import 'package:osrmtesting/features/login/domain/entities/auth_form.dart';

abstract interface class IAuthRepository {
  Future<BaseState> login(AuthFormEntity data);
  Future<BaseState> fetchAccountData();
}
