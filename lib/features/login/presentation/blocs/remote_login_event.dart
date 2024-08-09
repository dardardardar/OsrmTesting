import 'package:equatable/equatable.dart';
import 'package:osrmtesting/features/login/domain/entities/auth_form.dart';

abstract class RemoteAuthEvent extends Equatable {
  final AuthFormEntity? formData;

  const RemoteAuthEvent({this.formData});

  @override
  List<Object> get props => [formData!];
}

class SendAuthData extends RemoteAuthEvent {
  const SendAuthData(AuthFormEntity formData) : super(formData: formData);
}

class FetchAccountData extends RemoteAuthEvent {
  const FetchAccountData();
}
