import 'package:equatable/equatable.dart';
import 'package:osrmtesting/features/login/domain/entities/auth_form.dart';

abstract class RemoteAccountDataEvent extends Equatable {
  final AuthFormEntity? formData;

  const RemoteAccountDataEvent({this.formData});

  @override
  List<Object> get props => [formData!];
}

class FetchAccountData extends RemoteAccountDataEvent {
  const FetchAccountData();
}

class Logout extends RemoteAccountDataEvent {
  const Logout();
}
